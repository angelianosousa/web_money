describe("Verificação dos campos de E-mail e Senha ", () => {
  it("Deve verificar se o campo de e-mail não está vazio", () => {
    cy.visit("http://localhost:3000/users/sign_up");

    cy.get('input[type="Email"]').type(" ");
    cy.get('input[type="submit"]').click();
    cy.get(".alert-danger")
      .should("exist")
      .within(() => {
        cy.get("li").should("have.length", 2);
        cy.contains("li", "E-mail não pode ficar em branco");
      });
  });

  it("Deve verificar se o campo de e-mail contém um e-mail válido", () => {
    cy.visit("http://localhost:3000/users/sign_up");

    cy.get('input[type="Email"]').type("email_invalido");
    cy.get('input[type="submit"]').click();

    cy.get('input[type="Email"]')
      .invoke("prop", "validationMessage")
      .should((texto) => {
        expect(texto).to.include('Inclua um "@"') ||
          expect(texto).to.include(
            "Please include an '@' in the email address."
          );
      });
  });
  it("Deve verificar se e-mail já não está cadastrado", () => {
    cy.visit("http://localhost:3000/users/sign_up");
    // cy.visit();
    cy.get('input[type="Email"]').type("user@user.com");
    cy.get('input[type="submit"]').click();
    cy.get(".alert-danger")
      .should("exist")
      .within(() => {
        cy.get("li").should("have.length", 2);
        cy.contains("li", "E-mail já está em uso");
      });
  });
  it("Deve verificar se o campo de senha não está vazio", () => {
    cy.visit("http://localhost:3000/users/sign_up");
    // cy.visit();
    cy.get('input[type="Email"]').type("newuser@newuser.com");
    cy.get('input[name="user[password]"]').type(" ");
    cy.get('input[type="submit"]').click();
    cy.get(".alert-danger")
      .should("exist")
      .within(() => {
        cy.get("li").should("have.length", 2);
        cy.contains("li", "Senha não pode ficar em branco");
      });
  });
  it("Deve verificar se o campo de senha contém menos de 6 caracteres", () => {
    cy.visit("http://localhost:3000/users/sign_up");

    cy.get('input[type="Email"]').type("newuser@newuser.com");
    cy.get('input[name="user[password]"]').type("123");
    cy.get('input[type="submit"]').click();
    cy.get(".alert-danger")
      .should("exist")
      .within(() => {
        cy.get("li").should("have.length", 2);
        cy.contains("li", "Senha é muito curto (mínimo: 6 caracteres)");
      });
  });
  it("Deve verificar se o campo de Senha de Confirmação está diferente do campo de Senha", () => {
    cy.visit("http://localhost:3000/users/sign_up");

    cy.get('input[type="Email"]').type("newuser@newuser.com");
    cy.get('input[name="user[password]"]').type("123456");
    cy.get('input[name="user[password_confirmation]"]').type("123");
    cy.get('input[type="submit"]').click();
    cy.get(".alert-danger")
      .should("exist")
      .within(() => {
        cy.get("li").should("have.length", 1);
        cy.contains("li", "Confirmação de Senha não é igual a Senha");
      });
  });
  it("Deve verificar se o cadastro de novo usuário foi concluído com sucesso.", () => {
    cy.visit("http://localhost:3000/users/sign_up");

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
