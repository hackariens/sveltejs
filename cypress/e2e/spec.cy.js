describe('template spec', () => {
  it('passes', () => {
    cy.visit(`https://${Cypress.env('SERVERNAME')}`, {failOnStatusCode: false});
    cy.screenshot('first-page');
  });
})