#include <ostream>
#include "3ac.hpp"
#include "err.hpp"

namespace negatron{

void IRProgram::allocGlobals(){
	std::string temp;
	for(auto it = globals.cbegin(); it != globals.cend(); ++it)
	{
		temp = "gbl_" + it->first->getName();
		it->second->setMemoryLoc(temp);
	}
	// TODO(Implement me)
}

void IRProgram::datagenX64(std::ostream& out){
	out << ".data\n";

	out << ".globl\tmain\n";
	allocGlobals();
	for(auto it = globals.cbegin(); it != globals.cend(); ++it)
	{
		out << it->second->getMemoryLoc() << ":\t.quad 0\n";
	}
	for(auto str : strings)
	{
		out << str.first->getName() << ": ";
		out << "\t.asciz " << str.second << '\n';
		str.first->setMemoryLoc(str.first->getName());
	}
	out << ".align 8\n";
	out << "\n.text\n\n";
	// TODO(Implement me)
}

void IRProgram::toX64(std::ostream& out){
	datagenX64(out);
	for(auto proc : procs)
	{
		proc->toX64(out);
	}
	// TODO(Implement me)
}

void Procedure::allocLocals(){
	std::string temp;
	size_t var = 0;
	//allocing local variables
	// cout << "temp:" << numTemps() << ',' << "local:" << localsSize() << '\n';
	for(auto it : locals)
	{
		var++;
		size_t temp1 = var * 8 + 16; //16 is for jumping over rbp and rip
		it.second->setMemoryLoc('-' + to_string(temp1) + "(%rbp)"); // -(16+ numOfLoc * 8)(%rbp)
	}
	//allocing function parameters
	var = 0;
	for(auto it : formals)
	{
		var++;
		size_t temp1 = (formals.size() - var) * 8; //allocating parameters
		it->setMemoryLoc(to_string(temp1) + "(%rbp)");
	}
	//allocing temps
	var = 0;
	for(auto it : temps)
	{
		var++;
		size_t temp3 = 16 + locals.size() * 8 + var * 8;
		it->setMemoryLoc('-' + to_string(temp3) + "(%rbp)");
	}
	// TODO(Implement me)
}

void Procedure::toX64(std::ostream& out){
	//Allocate all locals
	allocLocals();
	//if main, don't do this
	if(!(myName == "main"))
	{
		out << "fun_" << myName << ":" << "\n";
	}
	else
	{
		out << myName << ":" << "\n";
	}

	//prologue
	enter->codegenX64(out); // 1st
	size_t locals = localsSize() + numTemps();
	// cout << localsSize() << ", " << numTemps() << '\n';
	out << "\t\t\t\tsubq\t" << '$' << locals * 8 << ", %rsp\n";

	// body
	for (auto quad : bodyQuads){
		quad->codegenLabels(out); // done
		quad->codegenX64(out); //2nd
	}

	//epologue
	leave->codegenLabels(out); //done
	leave->codegenX64(out); //?


}

void Quad::codegenLabels(std::ostream& out){
	if (labels.empty()){ return; }

	size_t numLabels = labels.size();
	size_t labelIdx = 0;
	for ( Label * label : labels){
		out << label->toString() << ": ";
		if (labelIdx != numLabels - 1){ out << "\n"; }
		labelIdx++;
	}
}

void BinOpQuad::codegenX64(std::ostream& out){
	if(op == SUB) // subtraction
	{
		src1->genLoad(out, "%rax");
		src2->genLoad(out, "%rbx");
		out << "\t\t\t\tsubq %rbx, %rax\n";
		dst->genStore(out, "%rax"); //save %rax to tmp
	}
	else if(op == MULT)
	{
		src1->genLoad(out, "%rax");
		src2->genLoad(out, "%rbx");
		out << "\t\t\t\timulq %rbx\n";
		dst->genStore(out, "%rax"); //save %rax to tmp
	}
	else if(op == DIV)
	{
		src1->genLoad(out, "%rax");
		src2->genLoad(out, "%rbx");
		out << "\t\t\t\tidivq %rbx\n";
		dst->genStore(out, "%rax"); //save %rax to tmp
	}
	else if(op == OR)
	{
		src1->genLoad(out, "%rax");
		src2->genLoad(out, "%rbx");
		out << "\t\t\t\torq %rbx, %rax\n";
		dst->genStore(out, "%rax"); //save %rax to tmp
	}
	else if(op == AND)
	{
		src1->genLoad(out, "%rax");
		src2->genLoad(out, "%rbx");
		out << "\t\t\t\tandq %rbx, %rax\n";
		dst->genStore(out, "%rax"); //save %rax to tmp
	}
	else if(op == NEQ)
	{
		src1->genLoad(out, "%rax");
		src2->genLoad(out, "%rbx");
		out << "\t\t\t\tcmpq %rbx, %rax\n";
		out << "\t\t\t\tsetne %al\n";
		dst->genStore(out, "%rax"); //save %rax to tmp
	}
	else if(op == LT)
	{
		src1->genLoad(out, "%rax");
		src2->genLoad(out, "%rbx");
		out << "\t\t\t\tcmpq %rbx, %rax\n";
		out << "\t\t\t\tsetl %al\n";
		dst->genStore(out, "%rax"); //save %rax to tmp
	}
	else if(op == LTE)
	{
		src1->genLoad(out, "%rax");
		src2->genLoad(out, "%rbx");
		out << "\t\t\t\tcmpq %rbx, %rax\n";
		out << "\t\t\t\tsetle %al\n";
		dst->genStore(out, "%rax"); //save %rax to tmp
	}
	// TODO(Implement me)
}

void UnaryOpQuad::codegenX64(std::ostream& out){
	if(op == NOT) // not
	{
		src->genLoad(out, "%rax");
		out << "\t\t\t\tcmpq $1, %rax\n";
		out << "\t\t\t\tsetne %al\n";
		dst->genStore(out, "%rax"); //save %rax to tmp
	}
	else if(op == NEG)
	{
		src->genLoad(out, "%rax");
		out << "\t\t\t\timulq $-1, %rax\n";
		dst->genStore(out, "%rax"); //save %rax to tmp
	}
	// TODO(Implement me)
}

void AssignQuad::codegenX64(std::ostream& out){
	src->genLoad(out, "%rax");
	dst->genStore(out, "%rax");
}

void LocQuad::codegenX64(std::ostream& out){
	// TODO(Implement me)
}

void JmpQuad::codegenX64(std::ostream& out){
	out << "\t\t\t\tjmp " << tgt->toString() << "\n";
}

void JmpIfQuad::codegenX64(std::ostream& out){
	cnd->genLoad(out, "%rax");
	out << "\t\t\t\tcmpq $1, %rax\n";
	if(invert)
	{
		out << "\t\t\t\tje " << tgt->toString() << '\n';
	}
	else
	{
		out << "\t\t\t\tjne " << tgt->toString() << '\n';
	}
	// TODO(Implement me)
}

void NopQuad::codegenX64(std::ostream& out){
	out << "nop" << "\n";
}

void IntrinsicQuad::codegenX64(std::ostream& out){
	if(this->myIntrinsic == OUTPUT)
	{
		if(myArg->getType() == ADDR)
		{
			// cout << myArg->toString() << '\n';
			myArg->genLoad(out, "%rdi");
			out << "\t\t\t\tcallq printString\n";
		}
		else
		{
			myArg->genLoad(out, "%rdi");
			out << "\t\t\t\tcallq printInt\n";
		}
	}
	else if(this->myIntrinsic == INPUT)
	{
		out << "\t\t\t\tcallq getInt\n";
		myArg->genStore(out, "%rax");
	}
	else if(this->myIntrinsic == EXIT) //syscall
	{
		out << '\n';
		out << "\t\t\t\tmovq\t%rax, %rdi\n"; // TODO
		out << "\t\t\t\tmovq $60, %rax\n";
		out << "\t\t\t\tsyscall\n";
	}
	// TODO(Implement me)
}

void CallQuad::codegenX64(std::ostream& out){
	size_t temp = 0; //parameters
	if(callee->getTypeString().find('-') != 0)
	{
		for(auto c : callee->getTypeString())
		{
			if(c == ',')
			{
				temp++;
			}
		}
		temp += 1;
	}
	out << "\t\t\t\tcallq fun_" << callee->getName() << '\n';
	out << "\t\t\t\taddq $" << temp * 8 << ", %rsp\n";
	// TODO(Implement me)
}

void EnterQuad::codegenX64(std::ostream& out){
	out << "\t\t\t\tpushq\t" << "%rbp\n";
	out << "\t\t\t\tmovq\t" << "%rsp, %rbp\n";
	out << "\t\t\t\taddq\t" << "$16, %rbp\n";
	// TODO(Implement me)
}

void LeaveQuad::codegenX64(std::ostream& out){
	size_t temp = 8 * myProc->numTemps() + 8 * myProc->localsSize();
	out << "\taddq $" << to_string(temp) << ", %rsp\n";
	out << "\t\t\t\tpopq %rbp\n";
	out << "\t\t\t\tretq\n";
	// TODO(Implement me)
}

void SetInQuad::codegenX64(std::ostream& out){
	opd->genLoad(out, "%rax");
	out << "\t\t\t\tsubq $8, %rsp\n";
	out << "\t\t\t\tmovq %rax, (%rsp)\n";
	// TODO(Implement me)
}

void GetInQuad::codegenX64(std::ostream& out){
	//We don't actually need to do anything here
}

void SetOutQuad::codegenX64(std::ostream& out){
	opd->genLoad(out, "%rax");
	// TODO(Implement me)
}

void GetOutQuad::codegenX64(std::ostream& out){
	opd->genStore(out, "%rax");
	// TODO(Implement me)
}

void SymOpd::genLoad(std::ostream & out, std::string regStr){
	out << "\t\t\t\tmovq\t" << this->getMemoryLoc() << ", " << regStr << '\n';
	// TODO(Implement me)
}

void SymOpd::genStore(std::ostream& out, std::string regStr){
	out << "\t\t\t\tmovq\t" << regStr << ", " << this->getMemoryLoc() << '\n';
	// TODO(Implement me)
}

void AuxOpd::genLoad(std::ostream & out, std::string regStr){
	if(this->myLoc != "UNINIT")
	{
		out << "\t\t\t\tmovq\t";

		if(this->getName().find("str_") != std::string::npos)
		{
			out << "$";
		}
		out << this->getMemoryLoc() << ", " << regStr << '\n';	}
	// TODO(Implement me)
}

void AuxOpd::genStore(std::ostream& out, std::string regStr){
	out << "\t\t\t\tmovq\t" << regStr << ", " << this->getMemoryLoc() << '\n';
	// TODO(Implement me)
}

void LitOpd::genLoad(std::ostream & out, std::string regStr){
	out << "\t\t\t\tmovq\t" << "$" << val << ", " << regStr << '\n';
	// TODO(Implement me)
}

void LitOpd::genStore(std::ostream& out, std::string regStr){
	throw new InternalError("Cannot use literal as l-val");
}

}
