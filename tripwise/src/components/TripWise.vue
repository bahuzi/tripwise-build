<template>
  <TripWiseTab />
</template>

<script lang="ts">
import { defineComponent } from "vue";
import TripWiseTab from "./TripWiseTab.vue";

export default defineComponent({
  name: "TripWise",
  components: {
    TripWiseTab,
  },
});
</script>
