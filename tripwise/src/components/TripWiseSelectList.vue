<template>
  <div class="w-full rounded-md shadow-md overflow-y-auto">
    <RadioGroup v-model="selected">
      <RadioGroupLabel class="sr-only">Detailed Schedule</RadioGroupLabel>
      <div class="space-y-2">
        <RadioGroupOption
          as="template"
          v-for="schedule in schedules"
          :key="schedule.name"
          :value="schedule"
          v-slot="{ active, checked }"
        >
          <div
            :class="[
              active
                ? 'ring-2 ring-offset-2 ring-offset-indigo-300 ring-white ring-opacity-60'
                : '',
              checked
                ? 'bg-indigo-900 bg-opacity-75 text-white '
                : 'bg-gray-100 ',
            ]"
            class="relative flex px-5 py-4 rounded-lg shadow-md cursor-pointer focus:outline-none"
          >
            <div class="flex items-center justify-between w-full">
              <div class="flex items-center">
                <div class="text-sm">
                  <RadioGroupLabel
                    as="p"
                    :class="checked ? 'text-white' : 'text-gray-900'"
                    class="font-medium"
                  >
                    Date: {{ schedule.date }} Flight Number:
                    {{ schedule.flightNumber }}
                  </RadioGroupLabel>
                  <RadioGroupDescription
                    as="span"
                    :class="checked ? 'text-indigo-100' : 'text-gray-500'"
                    class="flex flex-col py-4 space-y-2"
                  >
                    <span
                      >From: {{ schedule.origin }} at
                      {{ schedule.flightStartAt }}</span
                    >
                    <span
                      >To: {{ schedule.destination }} at
                      {{ schedule.flightEndAt }}</span
                    >
                    <span>Cost: {{ schedule.price }}</span>
                  </RadioGroupDescription>
                </div>
              </div>
              <div v-show="checked" class="flex-shrink-0 text-white">
                <svg class="w-6 h-6" viewBox="0 0 24 24" fill="none">
                  <circle
                    cx="12"
                    cy="12"
                    r="12"
                    fill="#fff"
                    fill-opacity="0.2"
                  />
                  <path
                    d="M7 13l3 3 7-7"
                    stroke="#fff"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
              </div>
            </div>
          </div>
        </RadioGroupOption>
      </div>
    </RadioGroup>
  </div>
</template>

<script>
import { ref, defineComponent } from "vue";
import {
  RadioGroup,
  RadioGroupLabel,
  RadioGroupDescription,
  RadioGroupOption,
} from "@headlessui/vue";

export default defineComponent({
  name: "TripWiseSelectList",
  props: ["data"],
  components: {
    RadioGroup,
    RadioGroupLabel,
    RadioGroupDescription,
    RadioGroupOption,
  },
  setup(props) {
    const schedules = ref([props.data]);

    const selected = ref(schedules.value[0]);

    return { selected, schedules };
  },
});
</script>
