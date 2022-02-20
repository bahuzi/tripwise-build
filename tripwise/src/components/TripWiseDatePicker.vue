<template>
  <DatePicker v-model="range" mode="dateTime" is-range :columns="2">
    <template v-slot="{ inputValue, inputEvents }">
      <div class="flex justify-center items-center">
        <input
          :value="inputValue.start"
          v-on="inputEvents.start"
          class="h-10 border px-2 py-1 w-44 rounded focus:outline-none focus:border-indigo-300"
        />
        <div class="px-3"><ArrowRightIcon class="h-9 w-4" /></div>
        <input
          :value="inputValue.end"
          v-on="inputEvents.end"
          class="h-10 border px-2 py-1 w-44 rounded focus:outline-none focus:border-indigo-300"
        />
      </div>
    </template>
  </DatePicker>
</template>

<script lang="ts">
import { ref, defineComponent } from "vue";
import { DatePicker } from "v-calendar";
import { ArrowRightIcon } from "@heroicons/vue/outline";
export default defineComponent({
  name: "TripWiseDatePicker",
  props: ['startDate', 'endDate'],
  components: {
    DatePicker,
    ArrowRightIcon
  },
  setup(props) {
    const range = ref({
      start: new Date(props.startDate),
      end: new Date(props.endDate),
    });
    return { range };
  },
});
</script>
<style src="v-calendar/dist/style.css"></style>