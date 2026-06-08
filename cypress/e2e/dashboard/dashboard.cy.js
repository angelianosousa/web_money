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
});
