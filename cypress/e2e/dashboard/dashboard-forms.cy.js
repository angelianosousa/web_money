import "../../commands/userCommands";
import "../application/form.cy";

describe("Verificação dos formulários na página de Dashboard ", () => {
  it("Deve testar a criação de uma nova Receita sem valor", () => {
    cy.loginSuccessfully();

    cy.openRecipeModal();

    cy.get("#newRecipeModal").within(() => {
      cy.get("#transaction_price_cents").type("0");
      cy.get('input[type="submit"][value="Salvar"]').click();
    });

    cy.get("span").should("contain", "Valor deve ser maior ou igual a 1");
  });

  it("Deve testar a criação de uma nova Receita", () => {
    cy.loginSuccessfully();

    cy.openRecipeModal();

    cy.get("#newRecipeModal").within(() => {
      cy.get("#transaction_price_cents").type("100");
      cy.get('input[type="submit"][value="Salvar"]').click();
    });

    cy.get("span").should("contain", "Movimentação criada com sucesso!!");
  });

  it("Deve testar a criação de uma nova Despesa sem valor", () => {
    cy.loginSuccessfully();

    cy.openExpenseModal();

    cy.get("#newExpenseModal").within(() => {
      cy.get("#transaction_price_cents").type("0");
      cy.get('input[type="submit"][value="Salvar"]').click();
    });

    cy.get("span").should("contain", "Valor deve ser maior ou igual a 1");
  });

  it("Deve testar a criação de uma nova Despesa", () => {
    cy.loginSuccessfully();

    cy.openExpenseModal();

    cy.get("#newExpenseModal").within(() => {
      cy.get("#transaction_price_cents").type("100");
      cy.get('input[type="submit"][value="Salvar"]').click();
    });

    cy.get("span").should("contain", "Movimentação criada com sucesso!!");
  });

  it("Deve testar a criação de Nova conta sem Título.", () => {
    cy.loginSuccessfully();

    cy.openNewAccountModal();

    cy.get("#newAccountModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Titulo não pode ficar em branco");
  });

  it("Deve testar a criação de Nova conta com Título e sem Montante.", () => {
    cy.loginSuccessfully();

    cy.openNewAccountModal();

    cy.get("#account_title").type("Titulo");
    cy.get("#newAccountModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Conta criada com sucesso");
  });

  it("Deve testar a criação de Nova Recorrência sem Título.", () => {
    cy.loginSuccessfully();

    cy.openNewBillModal();

    cy.get("#newBillModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Titulo não pode ficar em branco");
  });

  it("Deve testar a criação de Nova Recorrência com Título e sem Vencimento.", () => {
    cy.loginSuccessfully();

    cy.openNewBillModal();

    cy.get("#bill_title").type("Título");
    cy.get("#newBillModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Vencimento não pode ficar em branco");
  });

  it("Deve testar a criação de Nova Recorrência com Título, Vencimento e sem Valor.", () => {
    const currentDate = new Date();
    const formattedDate = currentDate.toISOString().split("T")[0];
    cy.loginSuccessfully();

    cy.openNewBillModal();

    cy.get("#bill_due_pay").type(formattedDate);

    cy.get("#bill_title").type("Título");
    cy.get("#newBillModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Valor não pode ficar em branco");
  });

  it("Deve testar a criação de Nova Recorrência com Título, Vencimento e Valor e Tipo Receita.", () => {
    const currentDate = new Date();
    const formattedDate = currentDate.toISOString().split("T")[0];
    cy.loginSuccessfully();

    cy.openNewBillModal();

    cy.get("#bill_due_pay").type(formattedDate);

    cy.get("#bill_title").type("Título");

    cy.get("#bill_price_cents").type("123.45");

    cy.get("#bill_bill_type").select("recipe");

    cy.get("#newBillModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Recorrência criada com sucesso");
  });

  it("Deve testar a criação de Nova Recorrência com Título, Vencimento e Valor e Tipo Despesa.", () => {
    const currentDate = new Date();
    const formattedDate = currentDate.toISOString().split("T")[0];
    cy.loginSuccessfully();

    cy.openNewBillModal();

    cy.get("#bill_due_pay").type(formattedDate);

    cy.get("#bill_title").type("Título");

    cy.get("#bill_price_cents").type("123.45");

    cy.get("#bill_bill_type").select("expense");

    cy.get("#newBillModal")
      .find('input[type="submit"][value="Salvar"]')
      .click();

    cy.get("span").should("contain", "Recorrência criada com sucesso");
  });
});
