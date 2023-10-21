import "../../commands/userCommands";
import "../application/navbar.cy";

const URL = "http://localhost:3000/dashboard#";

describe("Verificação dos componentes na página de Dashboard ", () => {
  it("Deve verificar se o usuário possui cadastro com sucesso.", () => {
    cy.loginSuccessfully();
  });

  it("Deve verificar os componentes da NavBar - Menu (LeftSideBar) - RightSideBar.", () => {
    cy.loginSuccessfully();
    cy.navBarTesting(URL);
  });

  it("Deve se o título da página redireciona normalmente.", () => {
    cy.loginSuccessfully();

    cy.get('a[href="dashboard"]').click();

    cy.url().should("eq", "http://localhost:3000/dashboard");
  });

  it("Deve testar a abertura dos modais de Receita e Despesa.", () => {
    cy.loginSuccessfully();

    cy.get('a[data-target="#newRecipeModal"]').click();

    cy.get("#newRecipeModal").should("have.css", "display", "block");

    cy.visit(URL);

    cy.get('a[data-target="#newExpenseModal"]').click();

    cy.get("#newExpenseModal").should("have.css", "display", "block");
  });

  it("Deve testar a abertura dos modais de Nova conta e Nova recorrência.", () => {
    cy.loginSuccessfully();

    cy.get("#dropdownActionButton").click();

    cy.get("#dropdownActionButton").should(
      "have.attr",
      "aria-expanded",
      "true"
    );

    cy.get('a[data-target="#newAccountModal"][data-toggle="modal"]').click();

    cy.wait(1000);

    cy.get("#newAccountModal").find("button.close").click();

    cy.get("#dropdownActionButton").click();

    cy.get("#dropdownActionButton").should(
      "have.attr",
      "aria-expanded",
      "true"
    );

    cy.get('a[data-target="#newBillModal"][data-toggle="modal"]').click();

    cy.wait(1000);

    cy.get("#newBillModal").find("button.close").click();
  });

  it("Deve testar a abertura e fechamento do filtro de pesquisa em Dashboard.", () => {
    cy.loginSuccessfully();

    cy.get('a[data-toggle="collapse"][data-target="#collapseSearch"]').click();

    cy.get("#collapseSearch").should("have.class", "collapse show");

    cy.get('a[data-toggle="collapse"][data-target="#collapseSearch"]').click();

    cy.get("#collapseSearch").should("have.class", "collapse");
  });
});
