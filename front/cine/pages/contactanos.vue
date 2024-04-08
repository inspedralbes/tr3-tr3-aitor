<template>
    <div class="contact">
      <div class="contact-container">
        <div class="contact-section">
          <h2>Contacto</h2>
          <address>
            <p>Cine Can Castellet</p>
            <p>Plaça Gaieta Mestres I Pares, 1</p>
            <p>08830, Sant Boi de Llobregat, España</p>
            <p>Teléfono: (+34) 93 284 07 19</p>
          <p>Correo electrónico: info@cancastellet.com</p>
          </address>
          <h2>Horario</h2>
          <p>Lunes a Viernes: 10:00 - 22:00</p>
          <p>Sábado y Domingo: 11:00 - 23:00</p>
        </div>
        <div class="contact-section">
          <h2>Mapa</h2>
          <div class="map-container">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d11919.470972015977!2d2.040544751024507!3d41.34523737595645!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x12a49b89a3a64b19%3A0x106c3dccd643c87b!2sCinemes%20Can%20Castellet!5e0!3m2!1sen!2ses!4v1649372129989!5m2!1sen!2ses" width="600" height="450" style="border:0;" loading="lazy"></iframe>
          </div>
        </div>
        <div class="contact-section">
          <h2>Descuentos</h2>
          <ul class="discount-list">
            <li>Estudiantes: 20% de descuento (presentando carné de estudiante)</li>
            <li>Mayores de 65 años: 15% de descuento</li>
            <li>Día del espectador (miércoles): 50% de descuento para todos</li>
            <li>Descuento especial: Primer jueves de cada mes, 40% de descuento para todos</li>
          </ul>
        </div>
        <div class="contact-section">
          <h2>Precios</h2>
          <ul class="price-list">
            <li>Día entre semana: 5,50€</li>
            <li>Fines de semana: 7,50€</li>
          </ul>
        </div>
        <div class="contact-section">
          <h2>Información Adicional</h2>
          <p>En Cine Can Castellet ofrecemos una amplia selección de películas de diferentes géneros para todos los gustos.</p>
          <p>Nuestro cine cuenta con cómodas instalaciones y ofrecemos servicios de alimentos y bebidas para que disfrutes al máximo de tu experiencia cinematográfica.</p>
          <p>¡No dudes en contactarnos para más información o para reservar tus entradas!</p>
        </div>
      </div>
    </div>
  </template>
  
  <style scoped>
  .contact {
    text-align: center;
  }
  
  .contact-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
  }
  
  .contact-section {
    flex: 1;
    margin: 10px;
    padding: 20px;
    border-radius: 10px;
  }
  
  .map-container {
    margin-top: 10px;
  }
  
  h1, h2 {
    color: #333;
  }
  
  .price-list, .discount-list {
    list-style: none;
    padding: 0;
  }
  
  .price-list li, .discount-list li {
    margin-bottom: 5px;
  }
  
  @media (max-width: 600px) {
    .contact-section {
      flex-basis: 100%;
    }
  }
  </style>
  