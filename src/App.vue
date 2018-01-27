<template>
  <div id="app">
    <div class="container">
      <div class="row">
        <div class="col-sm-3"></div>
        <div id="sliders" class="col-sm-6">
          <label>Height 1: {{height_1}}</label>
          <vue-slider ref="slider" :min="min_height" :max="max_height_1" v-model="height_1" tooltip="hover"></vue-slider>
          <label>Height 2: {{height_2}}</label>
          <vue-slider ref="slider" :min="min_height" :max="max_height_2" v-model="height_2" tooltip="hover"></vue-slider>
          <label>Height 3: {{height_3}}</label>
          <vue-slider ref="slider" :min="min_height" :max="max_height_3" v-model="height_3" tooltip="hover"></vue-slider>

          <br/>
          Total Height: {{total_height}}
        </div>
        <div class="col-sm-3"></div>
      </div>
    </div>
    <WebGL/>
  </div>
</template>

<script>
import vueSlider from "vue-slider-component";
import WebGL from "./components/WebGL";

var min_height = 1;
var max_height = 100;

export default {
  name: "App",
  components: {
    vueSlider,
    WebGL
  },
  data() {
    return {
      min_height: min_height,
      height_1: min_height,
      height_2: min_height,
      height_3: min_height,
      total_height: min_height * 3
    }
  },
  computed: {
    max_height_1: function() {
      return max_height - (this.height_2 + this.height_3);
    },
    max_height_2: function() {
      return max_height - (this.height_1 + this.height_3);
    },
    max_height_3: function() {
      return max_height - (this.height_1 + this.height_2);
    }
  },
  watch: {
    height_1: function (val) {
      this.total_height = val + this.height_2 + this.height_3;
    },
    height_2: function (val) {
      this.total_height = val + this.height_1 + this.height_3;
    },
    height_3: function (val) {
      this.total_height = val + this.height_1 + this.height_2;
    },
  }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
