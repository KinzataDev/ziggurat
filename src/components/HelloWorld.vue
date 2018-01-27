<template>
  <div class="hello">
    <span>{{height_1}}</span>
    <br/>
    <vue-slider ref="slider" v-model="height_1"></vue-slider>
    
  </div>
</template>

<script>

import Vue from 'vue';
import vueSlider from 'vue-slider-component';

new Vue({
  el: '#hello',
  components: {
    vueSlider
  },
  data: {
    height_1: 1
  }
});


</script>