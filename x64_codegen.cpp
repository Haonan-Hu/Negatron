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
	TODO(Implement me)
}

void UnaryOpQuad::codegenX64(std::ostream& out){
	TODO(Implement me)
}

void AssignQuad::codegenX64(std::ostream& out){
	src->genLoad(out, "%rax");
	dst->genStore(out, "%rax");
}

void LocQuad::codegenX64(std::ostream& out){
	TODO(Implement me)
}

void JmpQuad::codegenX64(std::ostream& out){
	out << "\t\t\t\tjmp " << tgt->toString() << "\n";
}

void JmpIfQuad::codegenX64(std::ostream& out){
	TODO(Implement me)
}

void NopQuad::codegenX64(std::ostream& out){
	out << "nop" << "\n";
}

void IntrinsicQuad::codegenX64(std::ostream& out){
	if(this->myIntrinsic == OUTPUT)
	{
		if(myArg->getType() == ADDR)
		{
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
	TODO(Implement me)
}

void EnterQuad::codegenX64(std::ostream& out){
	out << "\t\t\t\tpushq\t" << "%rbp\n";
	out << "\t\t\t\tmovq\t" << "%rsp, %rbp\n";
	out << "\t\t\t\taddq\t" << "$16, %rbp\n";
	// TODO(Implement me)
}

void LeaveQuad::codegenX64(std::ostream& out){
	TODO(Implement me)
}

void SetInQuad::codegenX64(std::ostream& out){
	TODO(Implement me)
}

void GetInQuad::codegenX64(std::ostream& out){
	//We don't actually need to do anything here
}

void SetOutQuad::codegenX64(std::ostream& out){
	opd->genLoad(out, "%rax");
	// TODO(Implement me)
}

void GetOutQuad::codegenX64(std::ostream& out){
	TODO(Implement me)
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
		out << "\t\t\t\tmovq\t$" << this->getMemoryLoc() << ", " << regStr << '\n';
	}
	// TODO(Implement me)
}

void AuxOpd::genStore(std::ostream& out, std::string regStr){
	TODO(Implement me)
}

void LitOpd::genLoad(std::ostream & out, std::string regStr){
	out << "\t\t\t\tmovq\t" << "$" << val << ", " << regStr << '\n';
	// TODO(Implement me)
}

void LitOpd::genStore(std::ostream& out, std::string regStr){
	throw new InternalError("Cannot use literal as l-val");
}

}
