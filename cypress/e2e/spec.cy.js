describe('template spec', () => {
  it('passes', () => {
    cy.visit('https://sveltejs.traefik.me');
    cy.screenshot('first-page');
  })
})