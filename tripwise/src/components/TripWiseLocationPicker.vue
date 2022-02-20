<template>
  <div class="flex justify-between">
    <Multiselect
      class="h-10 border px-2 py-1 w-44 rounded focus:outline-none focus:border-indigo-300"
      v-model="originSelect"
      :options="options"
      :searchable="true"
      placeholder="Origin"
    />
    <div class="px-3"><ArrowRightIcon class="h-9 w-4" /></div>
    <Multiselect
      class="h-10 border px-2 py-1 w-44 rounded focus:outline-none focus:border-indigo-300"
      v-model="destinationSelect"
      :options="options"
      :searchable="true"
      placeholder="Destination"
    />
  </div>
</template>

<script lang="ts">
import { ref, defineComponent } from "vue";
import Multiselect from "@vueform/multiselect";
import { ArrowRightIcon } from "@heroicons/vue/outline";
import airportsData from "./data/airports.json";
export default defineComponent({
  name: "TripWiseLocationPicker",
  props: ["origin", "destination"],
  components: {
    Multiselect,
    ArrowRightIcon,
  },
  setup(props) {
    const originSelect = ref(props.origin);
    const destinationSelect = ref(props.destination);
    const options = ref(airportsData);
    return { originSelect, destinationSelect, options };
  },
});
</script>
<style src="@vueform/multiselect/themes/default.css"></style>
