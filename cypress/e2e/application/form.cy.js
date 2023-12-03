Cypress.Commands.add("openRecipeModal", () => {
  cy.get('a[data-target="#newRecipeModal"]').click();

  cy.get("#newRecipeModal").should("have.css", "display", "block");
});

Cypress.Commands.add("openExpenseModal", () => {
  cy.get('a[data-target="#newExpenseModal"]').click();

  cy.get("#newExpenseModal").should("have.css", "display", "block");
});

Cypress.Commands.add("openNewAccountModal", () => {
  cy.get("#dropdownActionButton").click();

  cy.get("#dropdownActionButton").should("have.attr", "aria-expanded", "true");

  cy.get('a[data-target="#newAccountModal"][data-toggle="modal"]').click();

  cy.wait(1000);
});

Cypress.Commands.add("openNewBillModal", () => {
  cy.get("#dropdownActionButton").click();

  cy.get("#dropdownActionButton").should("have.attr", "aria-expanded", "true");

  cy.get('a[data-target="#newBillModal"][data-toggle="modal"]').click();

  cy.wait(1000);
});
