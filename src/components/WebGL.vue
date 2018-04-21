<template>
  <div id='scene' ref='scene'></div>
</template>

<script>

const THREE = require('three');
const exportSTL = require('threejs-export-stl');
var OrbitControls = require('three-orbit-controls')(THREE);

var camera, controls, scene, renderer;
var topCube, midCube, botCube;
var container;
var geometry;
// Set the scene size.
var WIDTH = 400;
var HEIGHT = 300;
var ZVAL = 0;

export default {
  name: "WebGL",
  props: ['height_1', 'height_2', 'height_3'],
  watch: {
    height_1: function(value) {
      this.updateZiggurat(value, this.height_2, this.height_3);
    },
    height_2: function(value) {
      this.updateZiggurat(this.height_1, value, this.height_3);
    },
    height_3: function(value) {
      this.updateZiggurat(this.height_1, this.height_2, value);
    }
  },
  methods: {
    init2: function() {
        scene = new THREE.Scene();
        scene.background = new THREE.Color( 0xcccccc );
        renderer = new THREE.WebGLRenderer();
        renderer.setSize(window.innerWidth, window.innerHeight);
        this.$refs.scene.appendChild(renderer.domElement);
        camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 1, 1000);
        camera.position.z = 300;
        controls = new OrbitControls(camera, renderer.domElement);
        controls.addEventListener('change', this.render);
        this.createStartingZiggurat(this.height_1, this.height_2, this.height_3);
        this.createLight();
        window.addEventListener( 'resize', this.onWindowResize, false );
        this.$on("export_stl_file_event", function() {
            alert('some stuff!')
            this.exportToSTLFile();
        });
    },
    updateZiggurat: function(topHeight, midHeight, bottomHeight) {
        
        topCube.position.y = (topHeight + midHeight) / 2;
        botCube.position.y = -((bottomHeight + midHeight) / 2);

        topCube.scale.y = topHeight;
        midCube.scale.y = midHeight;
        botCube.scale.y = bottomHeight;

        this.render();
    },
    createStartingZiggurat: function(topHeight, medHeight, lowHeight) {
        var topMaterial = new THREE.MeshBasicMaterial({
            color : 0x00ff00
        });
        var midMaterial = new THREE.MeshBasicMaterial({
            color : 0xff0000
        });
        var botMaterial = new THREE.MeshBasicMaterial({
            color : 0x0000ff
        });
        var TOPWIDTH = 20;
        var MIDWIDTH = 40;
        var BOTWIDTH = 60;
        var topGeometry = new THREE.BoxGeometry(TOPWIDTH, 1, TOPWIDTH)
        topCube = new THREE.Mesh(topGeometry, topMaterial);
        topCube.scale.y = topHeight;
        topCube.position.z = ZVAL;
        topCube.position.y = (topHeight + medHeight) / 2;
        scene.add(topCube);

        var medGeometry = new THREE.BoxGeometry(MIDWIDTH, 1, MIDWIDTH)
        midCube = new THREE.Mesh(medGeometry, midMaterial);
        midCube.scale.y = medHeight;
        midCube.position.z = ZVAL;
        midCube.position.y = 0;
        scene.add(midCube);

        var lowGeometry = new THREE.BoxGeometry(BOTWIDTH, 1, BOTWIDTH)
        botCube = new THREE.Mesh(lowGeometry, botMaterial);
        botCube.scale.y = lowHeight;
        botCube.position.z = ZVAL;
        botCube.position.y = -((lowHeight + medHeight) / 2);
        scene.add(botCube);
    },
    createLight() {
            
        // create a point light
        var lights = [];
        lights[ 0 ] = new THREE.PointLight( 0xffffff, 1, 0 );
        lights[ 1 ] = new THREE.PointLight( 0xffffff, 1, 0 );
        lights[ 2 ] = new THREE.PointLight( 0xffffff, 1, 0 );
        lights[ 0 ].position.set( 0, 200, 0 );
        lights[ 1 ].position.set( 100, 200, 100 );
        lights[ 2 ].position.set( - 100, - 200, - 100 );
        scene.add( lights[ 0 ] );
        scene.add( lights[ 1 ] );
        scene.add( lights[ 2 ] );
    },
    animate: function() {
        requestAnimationFrame(animate);
        controls.update();
        this.render()
    },
    render: function() {
        renderer.render( scene, camera );
    },
    onWindowResize: function() {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize( window.innerWidth, window.innerHeight );
    },
    exportToSTLFile: function() {
        // todo get meshes from the existing cubes
        var bigOlGeometry = new THREE.Geometry();
        bigOlGeometry.mergeMesh(topCube);
        bigOlGeometry.mergeMesh(midCube);
        bigOlGeometry.mergeMesh(botCube);

        var stringExport = exportSTL.fromGeometry(bigOlGeometry, false)
        // todo merge the cube meshes into one geometry
        // todo export the geometry to an STL file
        alert(JSON.stringify(stringExport));
    }
  },
  mounted: function () {
    this.init2();
    this.render();
  }
};


    


  
    


</script>

<style>

</style>
