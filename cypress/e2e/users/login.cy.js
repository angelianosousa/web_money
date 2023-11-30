describe("Verificação dos campos de E-mail e Senha ", () => {
  it("Deve verificar se o campo de e-mail não está vazio", () => {
    cy.visit("http://localhost:3000/users/sign_in");

    cy.get('input[placeholder="Email"]').type(" ");

    cy.get('input[type="submit"]').click();

    cy.get('input[placeholder="Email"]')
      .invoke("prop", "validationMessage")
      .should("include", "Please fill out this field.");
  });

  it("Deve verificar se o campo de e-mail contém um e-mail válido", () => {
    cy.visit("http://localhost:3000/users/sign_in");

    cy.get('input[placeholder="Email"]').type("email_invalido");

    cy.get('input[type="submit"]').click();

    cy.get('input[placeholder="Email"]')
      .invoke("prop", "validationMessage")
      .should("include", "Please include an '@' in the email address.");
  });

  it("Deve verificar se o campo de senha não está vazio", () => {
    cy.visit("http://localhost:3000/users/sign_in");

    cy.get('input[placeholder="Email"]').type("user@user.com");
    cy.get('input[placeholder="Sua senha"]').type(" ");

    cy.get('input[type="submit"]').click();

    cy.get('input[placeholder="Sua senha"]')
      .invoke("prop", "validationMessage")
      .should("include", "Please fill out this field.");
  });

  it("Deve verificar se o usuário possui não possui cadastro.", () => {
    cy.visit("http://localhost:3000/users/sign_in");

    cy.get('input[placeholder="Email"]').type("user@user.com");
    cy.get('input[placeholder="Sua senha"]').type("wrongpassword");

    cy.get('input[type="submit"]').click();

    cy.url().should("eq", "http://localhost:3000/users/sign_in");
  });

  it("Deve verificar se o usuário possui cadastro com sucesso.", () => {
    cy.visit("http://localhost:3000/users/sign_in");
    // cy.visit();

    cy.get('input[placeholder="Email"]').type("user@user.com");
    cy.get('input[placeholder="Sua senha"]').type("user123");

    cy.get('input[type="submit"]').click();

    cy.url().should("eq", "http://localhost:3000/");
    cy.get("span").should("contain", "Fez login com sucesso.");
  });

  it("Deve verificar se o usuário já está autenticado.", () => {
    cy.visit("http://localhost:3000/users/sign_in");
    // cy.visit();

    cy.get('input[placeholder="Email"]').type("user@user.com");
    cy.get('input[placeholder="Sua senha"]').type("user123");

    cy.get('input[type="submit"]').click();

    cy.visit("http://localhost:3000/users/sign_in");
    // cy.visit();

    cy.url().should("eq", "http://localhost:3000/");
    cy.get("span").should("contain", "Você já está logado.");
  });
});
