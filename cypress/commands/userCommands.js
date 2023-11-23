Cypress.Commands.add("loginSuccessfully", () => {
  cy.visit("http://localhost:3000/users/sign_in");
  // cy.visit();

  cy.get('input[placeholder="Email"]').type("user@user.com");
  cy.get('input[placeholder="Sua senha"]').type("user123");

  cy.get('input[type="submit"]').click();

  cy.url().should("eq", "http://localhost:3000/");
  cy.get("span").should("contain", "Fez login com sucesso.");
});
