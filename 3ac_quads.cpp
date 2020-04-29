#include "3ac.hpp"

namespace negatron{


Quad::Quad() : myComment(""){
}

void Quad::addLabel(Label * label){
	labels.push_back(label);
}

void Quad::setComment(std::string commentIn){
	this->myComment = commentIn;
}

std::string Quad::commentStr(){
	if (myComment.length() > 0){
		return "  #" + myComment;
	}
	return "";
}

std::string Quad::toString(bool verbose){
	auto res = std::string("");

	auto first = true;
	for (auto label : labels){
		if (first){ first = false; }
		else { res += ","; }

		res += label->toString();
	}
	if (!first){ res += ": "; }

	res += this->repr();
	if (verbose){
		res += commentStr();
	}

	return res;
}

CallQuad::CallQuad(SemSymbol * calleeIn) : callee(calleeIn){ }

std::string CallQuad::repr(){
	return "call " + callee->getName();
}

EnterQuad::EnterQuad(Procedure * procIn) : Quad(), myProc(procIn)
{ }

std::string EnterQuad::repr(){
	return "enter " + myProc->getName();
}

LeaveQuad::LeaveQuad(Procedure * procIn) : Quad(), myProc(procIn)
{ }

std::string LeaveQuad::repr(){
	return "leave " + myProc->getName();
}

std::string AssignQuad::repr(){
	return dst->toString() + " := " + src->toString();
	
}

BinOpQuad::BinOpQuad(Opd * dstIn, BinOp opIn, Opd * src1In, Opd * src2In)
: dst(dstIn), op(opIn), src1(src1In), src2(src2In){ }

std::string BinOpQuad::repr(){
	std::string opString;
	switch (op){
	case SUB:
		opString = " SUB ";
		break;
	case DIV:
		opString = " DIV ";
		break;
	case MULT:
		opString = " MULT ";
		break;
	case OR:
		opString = " OR ";
		break;
	case AND:
		opString = " AND ";
		break;
	case EQ:
		opString = " EQ ";
		break;
	case NEQ:
		opString = " NEQ ";
		break;
	case LT:
		opString = " LT ";
		break;
	case LTE:
		opString = " LTE ";
		break;
	}
	return dst->toString() + " := " 
		+ src1->toString()
		+ opString
		+ src2->toString();
}

UnaryOpQuad::UnaryOpQuad(Opd * dstIn, UnaryOp opIn, Opd * srcIn)
: dst(dstIn), op(opIn), src(srcIn) { }

std::string UnaryOpQuad::repr(){
	std::string opString;
	switch (op){
	case NEG:
		opString = "NEG ";
		break;
	case NOT:
		opString = "NOT ";
	}
	return dst->toString() + " := " 
		+ opString
		+ src->toString();
}

IntrinsicQuad::IntrinsicQuad(Intrinsic intrinsic, Opd * opd) 
: myArg(opd), myIntrinsic(intrinsic){ }

std::string IntrinsicQuad::repr(){
	std::string res;
	switch (myIntrinsic){
	case INPUT:
		res = "INPUT " + myArg->toString();
		break;
	case OUTPUT:
		res = "OUTPUT " + myArg->toString();
		break;
	case EXIT:
		res = "EXIT";
		break;
	}
	return res;
}

JmpQuad::JmpQuad(Label * tgtIn)
: Quad(), tgt(tgtIn){ }

std::string JmpQuad::repr(){
	std::string res = "";
	return "goto " + tgt->toString();
}

JmpIfQuad::JmpIfQuad(Opd * cndIn, bool invertIn, Label * tgtIn) 
: Quad(), cnd(cndIn), invert(invertIn), tgt(tgtIn){ }

std::string JmpIfQuad::repr(){
	std::string res = "";
	if (invert){
		res += "iftrue ";
	} else {
		res += "iffalse ";
	}
	res += cnd->toString();
	res += " goto ";
	res += tgt->toString();
	return res;
}

NopQuad::NopQuad()
: Quad() { }

std::string NopQuad::repr(){
	return "nop";
}

GetOutQuad::GetOutQuad(size_t indexIn, Opd * opdIn)
: Quad(), index(indexIn), opd(opdIn) { }

std::string GetOutQuad::repr(){
	std::string res = "";
	res += "getout " + std::to_string(index) + " " + opd->toString(); 
	return res;
}

SetInQuad::SetInQuad(size_t indexIn, Opd * opdIn) 
: index(indexIn), opd(opdIn){
}

std::string SetInQuad::repr(){
	std::string res = "";
	res += "setin " + std::to_string(index) + " " + opd->toString(); 
	return res;
}

GetInQuad::GetInQuad(size_t indexIn, Opd * opdIn) 
: index(indexIn), opd(opdIn){
}

std::string GetInQuad::repr(){
	std::string res = "";
	res += "getin " + std::to_string(index) + " " + opd->toString(); 
	return res;
}

SetOutQuad::SetOutQuad(size_t indexIn, Opd * opdIn) 
: index(indexIn), opd(opdIn){
}

std::string SetOutQuad::repr(){
	std::string res = "";
	res += "setout " + std::to_string(index) + " " + opd->toString(); 
	return res;
}

}


