describe("Verificação dos campos de E-mail e Senha ", () => {
  it("Deve verificar se o campo de e-mail não está vazio", () => {
    cy.visit("http://localhost:3000/users/sign_up");
    // cy.visit();

    cy.get('input[type="Email"]').type(" ");

    cy.get('input[type="submit"]').click();

    cy.get('span[data-notify="message"]')
      .contains("Email não pode ficar em branco")
      .should("exist");
  });

  it("Deve verificar se o campo de e-mail contém um e-mail válido", () => {
    cy.visit("http://localhost:3000/users/sign_up");
    // cy.visit();

    cy.get('input[type="Email"]').type("email_invalido");

    cy.get('input[type="submit"]').click();

    cy.get('input[type="Email"]')
      .invoke("prop", "validationMessage")
      .should("include", 'Inclua um "@"');
  });

  it("Deve verificar se e-mail já não está cadastrado", () => {
    cy.visit("http://localhost:3000/users/sign_up");
    // cy.visit();

    cy.get('input[type="Email"]').type("user@user.com");

    cy.get('input[type="submit"]').click();

    cy.get('span[data-notify="message"]')
      .contains("Email já está em uso")
      .should("exist");
  });

  it("Deve verificar se o campo de senha não está vazio", () => {
    cy.visit("http://localhost:3000/users/sign_up");
    // cy.visit();

    cy.get('input[type="Email"]').type("newuser@newuser.com");
    cy.get('input[name="user[password]"]').type(" ");

    cy.get('input[type="submit"]').click();

    cy.get('span[data-notify="message"]')
      .contains("Password não pode ficar em branco")
      .should("exist");
  });

  it("Deve verificar se o campo de senha contém menos de 6 caracteres", () => {
    cy.visit("http://localhost:3000/users/sign_up");
    // cy.visit();

    cy.get('input[type="Email"]').type("newuser@newuser.com");
    cy.get('input[name="user[password]"]').type("123");

    cy.get('input[type="submit"]').click();

    cy.get('span[data-notify="message"]')
      .contains("Password é muito curto (mínimo: 6 caracteres)")
      .should("exist");
  });

  it("Deve verificar se o campo de Senha de Confirmação está diferente do campo de Senha", () => {
    cy.visit("http://localhost:3000/users/sign_up");
    // cy.visit();

    cy.get('input[type="Email"]').type("newuser@newuser.com");
    cy.get('input[name="user[password]"]').type("123456");
    cy.get('input[name="user[password_confirmation]"]').type("123");

    cy.get('input[type="submit"]').click();

    cy.get('span[data-notify="message"]')
      .contains("Password confirmation não é igual a Password")
      .should("exist");
  });

  it("Deve verificar se o cadastro de novo usuário foi concluído com sucesso.", () => {
    cy.visit("http://localhost:3000/users/sign_up");
    // cy.visit();

    const randomAccountNumber = Math.floor(Math.random() * 9000) + 1000;
    const baseEmail = `newuser${randomAccountNumber}@newuser.com`;

    cy.get('input[type="Email"]').type(baseEmail);
    cy.get('input[name="user[password]"]').type("123456");
    cy.get('input[name="user[password_confirmation]"]').type("123456");

    cy.get('input[type="submit"]').click();

    cy.url().should("eq", "http://localhost:3000/");
    cy.get("span").should(
      "contain",
      "Bem-vindo! Você se registrou com sucesso."
    );
  });
});
