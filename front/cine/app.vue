<script>
import Header from '../cine/components/Header.vue';
import Footer from '../cine/components/Footer.vue';

export default {
  components: {
    Header,
    Footer,
  }
}
</script>

<template>
  <title>Cine Can Casteller</title>
  <div>
    <Header />
    <router-view />
    <Footer />
  </div>
</template>

<style>
body{
  margin: 0;
}
</style>