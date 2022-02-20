<template>
  <div class="grid grid-cols-5 py-5 pr-5 p-5">
    <draggable
      v-model="list"
      tag="ul"
      group="flightPlanner"
      class="p-2"
      item-key="id"
      :animation="200"
      ghost-class="ghost"
      filter=".action-button"
      @start="dragging = true"
      @end="dragging = false"
    >
      <template #item="{ element }">
        <li
          :key="element.id"
          class="rounded-lg p-4 mb-2 bg-indigo-100 bg-opacity-75 shadow-lg space-y-3 cursor-move h-40 w-70 hover:bg-indigo-50 hover:bg-opacity-30"
        >
          <div class="flex items-center space-x-3">
            <CalendarIcon class="h-6 w-6 stroke-indigo-600" />
            <h3 class="font-semibold truncate text-ms">
              Date ({{ formateDate(element.date) }})
            </h3>
          </div>
          <p class="text-xs">
            {{ formateDate(element.date) }} Add some detailes here ...
          </p>
        </li>
      </template>
    </draggable>

    <draggable
      v-model="list"
      tag="ul"
      group="flightPlanner"
      item-key="id"
      class="p-2"
      :animation="200"
      ghost-class="moving-card"
      filter=".action-button"
      @start="dragging = true"
      @end="dragging = false"
    >
      <template #item="{ element }">
        <li
          :key="element.id"
          class="rounded-lg p-4 mb-2 bg-indigo-100 bg-opacity-75 shadow-lg space-y-3 cursor-move h-40 w-70 hover:bg-indigo-50 hover:bg-opacity-30"
        >
          <div class="flex items-center space-x-3">
            <ArrowCircleRightIcon class="h-6 w-6 stroke-indigo-600" />
            <h3 class="font-semibold truncate text-ms">
              Original Airport ({{ element.location }})
            </h3>
          </div>
          <p class="text-xs">
            {{ element.origin }}:
            {{ formateTime(element.flightStartAt) }}
          </p>
        </li>
      </template>
    </draggable>
    <draggable
      v-model="list"
      tag="ul"
      group="flightPlanner"
      item-key="id"
      class="p-2"
      :animation="200"
      ghost-class="moving-card"
      filter=".action-button"
      @start="dragging = true"
      @end="dragging = false"
    >
      <template #item="{ element }">
        <li
          :key="element.id"
          class="rounded-lg p-4 mb-2 bg-indigo-100 bg-opacity-75 shadow-lg space-y-3 cursor-move h-40 w-70 hover:bg-indigo-50 hover:bg-opacity-30"
        >
          <div class="flex items-center space-x-3">
            <ArrowCircleDownIcon class="h-6 w-6 stroke-indigo-600" />
            <h3 class="font-semibold truncate text-ms">
              Destination ({{ element.destination }})
            </h3>
          </div>
          <p class="text-xs">
            {{ element.destination }}:
            {{ formateTime(element.flightEndAt) }}
          </p>
        </li>
      </template>
    </draggable>
    <draggable
      v-model="list"
      tag="ul"
      group="flightPlanner"
      item-key="id"
      class="p-2"
      :animation="200"
      ghost-class="moving-card"
      filter=".action-button"
      @start="dragging = true"
      @end="dragging = false"
    >
      <template #item="{ element }">
        <li
          :key="element.id"
          class="rounded-lg p-4 mb-2 bg-indigo-100 bg-opacity-75 shadow-lg space-y-3 cursor-move h-40 w-70 hover:bg-indigo-50 hover:bg-opacity-30"
        >
          <div class="flex items-center space-x-3">
            <ClockIcon class="h-6 w-6 stroke-indigo-600" />
            <h3 class="font-semibold truncate text-ms">
              Flight Number ({{ element.flightNumber }})
            </h3>
          </div>
          <p class="text-xs">The Flight Number is {{ element.flightNumber }}</p>
        </li>
      </template>
    </draggable>
    <draggable
      v-model="list"
      tag="ul"
      group="flightPlanner"
      item-key="id"
      class="p-2"
      :animation="200"
      ghost-class="moving-card"
      filter=".action-button"
      @start="dragging = true"
      @end="dragging = false"
    >
      <template #item="{ element }">
        <li
          :key="element.id"
          class="rounded-lg p-4 mb-2 bg-indigo-100 bg-opacity-75 shadow-lg space-y-3 cursor-move h-40 w-70 hover:bg-indigo-50 hover:bg-opacity-30"
        >
          <div class="flex items-center space-x-3">
            <CurrencyDollarIcon class="h-6 w-6 stroke-indigo-600" />
            <h3 class="font-semibold truncate text-ms">
              Flight Cost ({{ formateCurrency(element.price) }})
            </h3>
          </div>
          <p class="text-xs">
            The total cost is {{ formateCurrency(element.price) }}
          </p>
        </li>
      </template>
    </draggable>
  </div>
</template>

<script lang="ts">
import sampleData from "./data/sample.json";
import Draggable from "vuedraggable";
import dayjs from "dayjs";
import { defineComponent, ref } from "vue";
import {
  CalendarIcon,
  ArrowCircleRightIcon,
  ArrowCircleDownIcon,
  ClockIcon,
  CurrencyDollarIcon,
} from "@heroicons/vue/outline";

export default defineComponent({
  name: "TripWiseDraggable",
  components: {
    Draggable,
    CalendarIcon,
    ArrowCircleRightIcon,
    ArrowCircleDownIcon,
    ClockIcon,
    CurrencyDollarIcon,
  },
  setup() {
    const list = ref(sampleData);
    const dragging = false;
    function formateDate(string: string) {
      const date = dayjs(string);
      if (string == "N/A") {
        return "";
      }
      return date.format("ddd MMMM D, YYYY");
    }
    function formateTime(string: string) {
      const date = dayjs(string);
      if (string == "N/A") {
        return "";
      }
      return date.format("ddd, MMM D, YY h:mm A ");
    }

    function formateCurrency(number: number) {
      if (number == null) {
        return "--";
      }
      return new Intl.NumberFormat("en-US", {
        style: "currency",
        currency: "USD",
      }).format(number);
    }

    return {
      list,
      dragging,
      formateDate,
      formateTime,
      formateCurrency,
    };
  },
});
</script>
