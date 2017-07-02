
protocol StmtVisitor {

    associatedtype StmtVisitorReturn

    func visitBlockStmt(_ stmt: Stmt.Block) -> StmtVisitorReturn
    func visitExpressionStmt(_ stmt: Stmt.Expression) -> StmtVisitorReturn
    func visitIfStmt(_ stmt: Stmt.If) -> StmtVisitorReturn
    func visitPrintStmt(_ stmt: Stmt.Print) -> StmtVisitorReturn
    func visitVarStmt(_ stmt: Stmt.Var) -> StmtVisitorReturn
}

class Stmt {

    func accept<V: StmtVisitor, R>(visitor: V) -> R where R == V.StmtVisitorReturn {
        fatalError()
    }

    class Block: Stmt {
        let statements: Array<Stmt>

        init(statements: Array<Stmt>) {
            self.statements = statements
        }

        override func accept<V: StmtVisitor, R>(visitor: V) -> R where R == V.StmtVisitorReturn {
            return visitor.visitBlockStmt(self)
        }
    }

    class Expression: Stmt {
        let expression: Expr

        init(expression: Expr) {
            self.expression = expression
        }

        override func accept<V: StmtVisitor, R>(visitor: V) -> R where R == V.StmtVisitorReturn {
            return visitor.visitExpressionStmt(self)
        }
    }

    class If: Stmt {
        let condition: Expr
        let thenBranch: Stmt
        let elseBranch: Stmt?

        init(condition: Expr, thenBranch: Stmt, elseBranch: Stmt?) {
            self.condition = condition
            self.thenBranch = thenBranch
            self.elseBranch = elseBranch
        }

        override func accept<V: StmtVisitor, R>(visitor: V) -> R where R == V.StmtVisitorReturn {
            return visitor.visitIfStmt(self)
        }
    }

    class Print: Stmt {
        let expression: Expr

        init(expression: Expr) {
            self.expression = expression
        }

        override func accept<V: StmtVisitor, R>(visitor: V) -> R where R == V.StmtVisitorReturn {
            return visitor.visitPrintStmt(self)
        }
    }

    class Var: Stmt {
        let name: Token
        let initializer: Expr?

        init(name: Token, initializer: Expr?) {
            self.name = name
            self.initializer = initializer
        }

        override func accept<V: StmtVisitor, R>(visitor: V) -> R where R == V.StmtVisitorReturn {
            return visitor.visitVarStmt(self)
        }
    }
}
