Cypress.Commands.add("navBarTesting", (url) => {
  cy.visit(url);
  // cy.visit();

  // Verify Dashboard Li
  cy.get("#sidebarCollapse").click();

  cy.get("#sidebar").should("be.active");

  cy.get("ul.list-unstyled.components li")
    .eq(0)
    .click()
    .should("have.class", "active");

  cy.url().should("eq", "http://localhost:3000/dashboard");

  // Verify Contas Li
  cy.get("#sidebarCollapse").click();

  cy.get("#sidebar").scrollIntoView().should("be.visible");

  cy.get("ul.list-unstyled.components li").eq(0).should("have.class", "active");
  cy.get("ul.list-unstyled.components li").eq(1).click();

  cy.url().should("eq", "http://localhost:3000/accounts");

  // Verify Metas Li
  cy.get("#sidebarCollapse").click();

  cy.get("#sidebar").scrollIntoView().should("be.visible");

  cy.get("ul.list-unstyled.components li").eq(1).should("have.class", "active");
  cy.get("ul.list-unstyled.components li").eq(2).click();

  cy.url().should("eq", "http://localhost:3000/budgets");

  // Verify Movimentações Li
  cy.get("#sidebarCollapse").click();

  cy.get("#sidebar").scrollIntoView().should("be.visible");

  cy.get("ul.list-unstyled.components li").eq(2).should("have.class", "active");
  cy.get("ul.list-unstyled.components li").eq(3).click();

  cy.url().should("eq", "http://localhost:3000/transactions");

  // Verify Categorias Li
  cy.get("#sidebarCollapse").click();

  cy.get("#sidebar").scrollIntoView().should("be.visible");

  cy.get("ul.list-unstyled.components li").eq(3).should("have.class", "active");
  cy.get("ul.list-unstyled.components li").eq(4).click();

  cy.url().should("eq", "http://localhost:3000/categories");

  // Verify Recorrencias Li
  cy.get("#sidebarCollapse").click();

  cy.get("#sidebar").scrollIntoView().should("be.visible");

  cy.get("ul.list-unstyled.components li").eq(4).should("have.class", "active");
  cy.get("ul.list-unstyled.components li").eq(5).click();

  cy.url().should("eq", "http://localhost:3000/bills");

  cy.get("#sidebarCollapse").click();

  cy.get("#sidebar").scrollIntoView().should("be.visible");
  cy.get("ul.list-unstyled.components li").eq(5).should("have.class", "active");

  // Verify RightSideBar Components

  // Verify Notificações
  cy.visit(url);
  // cy.visit();

  cy.get('a[href="/notifications"]').click();

  cy.url().should("eq", "http://localhost:3000/notifications");

  // Verify Editar Perfil
  cy.visit(url);
  // cy.visit();

  cy.get('a[href="/user_profile/1/edit"]').click();

  cy.url().should("eq", "http://localhost:3000/user_profile/1/edit");

  // Verify Logout Deny
  cy.visit(url);
  // cy.visit();
  cy.window({ log: false }).then((win) => {
    if (typeof win.confirm.original === "undefined") {
      cy.stub(win, "confirm").as("confirm");
      win.confirm.original = win.confirm;
    }
  });

  cy.get('a[href="/users/sign_out"]').click();

  // Verify Logout Acceptance
  cy.visit(url);
  // cy.visit();
  cy.get("@confirm").invoke("restore");
  cy.get('a[href="/users/sign_out"]').click();
});
