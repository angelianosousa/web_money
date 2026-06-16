import "../../commands/userCommands";
import "../application/form.cy";

describe("Verificação dos formulários na página de Dashboard ", () => {
  it("Deve testar a criação de uma nova Receita sem valor", () => {
    cy.loginSuccessfully();

    cy.openRecipeModal();

    cy.get("#newRecipeModal").within(() => {
      cy.get("#transaction_price").clear().type("0");
      cy.get('input[type="submit"][value="Salvar"]').click();
    });

    cy.get("span").should("contain", "Valor deve ser maior ou igual a 1");
  });

  it("Deve testar a criação de uma nova Receita", () => {
    cy.loginSuccessfully();

    cy.openRecipeModal();

    cy.get("#newRecipeModal").within(() => {
      cy.get("#transaction_price").clear().type("100");
      cy.get('input[type="submit"][value="Salvar"]').click();
    });

    cy.get("span").should("contain", "Movimentação criada com sucesso!!");
  });

  it("Deve testar a criação de uma nova Despesa sem valor", () => {
    cy.loginSuccessfully();

    cy.openExpenseModal();

    cy.get("#newExpenseModal").within(() => {
      cy.get("#transaction_price").clear().type("0");
      cy.get('input[type="submit"][value="Salvar"]').click();
    });

    cy.get("span").should("contain", "Valor deve ser maior ou igual a 1");
  });

  it("Deve testar a criação de uma nova Despesa", () => {
    cy.loginSuccessfully();

    cy.openExpenseModal();

    cy.get("#newExpenseModal").within(() => {
      cy.get("#transaction_price").clear().type("100");
      cy.get('input[type="submit"][value="Salvar"]').click();
    });

    cy.get("span").should("contain", "Movimentação criada com sucesso!!");
  });

  // Account
  it("Deve testar a criação de Novo banco sem Título.", () => {
    cy.loginSuccessfully();

    cy.openNewAccountModal();

    cy.get("#newAccountModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Titulo não pode ficar em branco");
  });

  it("Deve testar a criação de Novo banco com Título.", () => {
    cy.loginSuccessfully();

    cy.openNewAccountModal();

    cy.get("#account_title").type("Titulo do Banco");
    cy.get("#newAccountModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Banco criado com sucesso");
  });

  // Bill
  it("Deve testar a criação de Novo Pag. Recorrente sem Título.", () => {
    cy.loginSuccessfully();

    cy.openNewBillModal();

    cy.get("#newBillModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Titulo não pode ficar em branco");
  });

  it("Deve testar a criação de Novo Pag. Recorrente com Título e sem Vencimento.", () => {
    cy.loginSuccessfully();

    cy.openNewBillModal();

    cy.get("#bill_title").type("Título");
    cy.get("#newBillModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Vencimento não pode ficar em branco");
  });

  it("Deve testar a criação de Novo Pag. Recorrente com Título, Vencimento e sem Valor.", () => {
    const currentDate = new Date();
    const formattedDate = currentDate.toISOString().split("T")[0];
    cy.loginSuccessfully();

    cy.openNewBillModal();

    cy.get("#bill_due_pay").type(formattedDate);

    cy.get("#bill_title").type("Título");
    cy.get("#newBillModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Valor deve ser maior ou igual a 1");
  });

  it("Deve testar a criação de Novo Pag. Recorrente com Título, Vencimento e Valor e Tipo Receita.", () => {
    const currentDate = new Date();
    const formattedDate = currentDate.toISOString().split("T")[0];
    cy.loginSuccessfully();

    cy.openNewBillModal();

    cy.get("#bill_due_pay").type(formattedDate);

    cy.get("#bill_title").type("Título Receita");

    cy.get("#bill_price").type("123.45");

    cy.get("#bill_bill_type").select("recipe");

    cy.get("#newBillModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Pag. Recorrente criado com sucesso");
  });

  it("Deve testar a criação de Nova Pag. Recorrente com Título, Vencimento e Valor e Tipo Despesa.", () => {
    const currentDate = new Date();
    const formattedDate = currentDate.toISOString().split("T")[0];
    cy.loginSuccessfully();

    cy.openNewBillModal();

    cy.get("#bill_due_pay").type(formattedDate);

    cy.get("#bill_title").type("Título Despesa");

    cy.get("#bill_price").type("123.45");

    cy.get("#bill_bill_type").select("expense");

    cy.get("#newBillModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Pag. Recorrente criado com sucesso");
  });
});
