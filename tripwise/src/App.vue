<template>
  <div class="min-h-screen bg-indigo-500 bg-opacity-50">
    <TripWise />
  </div>
</template>

<script lang="ts">
import { Options, Vue } from "vue-class-component";
import TripWise from "./components/TripWise.vue";

@Options({
  components: {
    TripWise,
  },
})
export default class App extends Vue {}
</script>
