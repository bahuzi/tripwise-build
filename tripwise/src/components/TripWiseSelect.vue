<template>
  <div class="h-96 flex flex-col justify-between overflow-hidden">
    <Transition
      name="custom-classes"
      enter-active-class="animate__animated animate__slideInLeft"
    >
      <div
        v-show="!show"
        class="flex justify-between bg-gray-100 bg-opacity-75 rounded-md shadow-md px-4 py-5"
      >
        <TripWiseDatePicker
          :startDate="modalData.data.flightStartAt"
          :endDate="modalData.data.flightEndAt"
        />
        <TripWiseLocationPicker
          :origin="modalData.data.origin"
          :destination="modalData.data.destination"
        />
      </div>
    </Transition>
    <Transition
      name="custom-classes"
      enter-active-class="animate__animated animate__slideInRight"
    >
      <TripWiseSelectList v-show="show" :data="modalData.data" />
    </Transition>
    <div class="flex justify-between mt-4">
      <button
        type="button"
        class="px-4 py-2 text-blue-900 bg-blue-100 border border-transparent rounded-md hover:bg-blue-200 focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-blue-500"
        @click="previous"
      >
        Previous
      </button>
      <button
        v-if="!confirmed"
        type="button"
        class="px-4 py-2 text-blue-900 bg-blue-100 border border-transparent rounded-md hover:bg-blue-200 focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-blue-500"
        @click="next"
      >
        Next
      </button>
      <button
        v-if="confirmed"
        type="button"
        class="px-4 py-2 text-blue-900 bg-blue-100 border border-transparent rounded-md hover:bg-blue-200 focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-blue-500"
        @click="confirm"
      >
        Confirm
      </button>
    </div>
  </div>
</template>

<script lang="ts">
import { ref, defineComponent } from "vue";
import TripWiseDatePicker from "./TripWiseDatePicker.vue";
import TripWiseLocationPicker from "./TripWiseLocationPicker.vue";
import TripWiseSelectList from "./TripWiseSelectList.vue";
export default defineComponent({
  name: "TripWiseSelect",
  props: ["modalData"],
  components: {
    TripWiseDatePicker,
    TripWiseLocationPicker,
    TripWiseSelectList,
  },
  setup(props, context) {
    const confirmed = ref(false);
    const show = ref(false);
    function confirm() {
      context.emit("onModal", "confirmed");
    }
    function next() {
      show.value = true;
      confirmed.value = !confirmed.value;
    }
    function previous() {
      show.value = false;
      confirmed.value = !confirmed.value;
    }
    return { show, confirmed, confirm, next, previous };
  },
});
</script>
