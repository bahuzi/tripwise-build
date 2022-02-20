<template>
  <div class="container mx-auto py-5">
    <TabGroup>
      <TabList
        class="flex space-x-1 rounded-xl bg-indigo-200 bg-opacity-50 drop-shadow-lg p-1"
      >
        <Tab
          v-for="category in categories"
          :key="category.id"
          v-slot="{ selected }"
          as="template"
        >
          <button
            :class="[
              'w-full py-2.5 text-sm leading-5 font-medium text-blue-700 rounded-lg uppercase font-bold',
              'focus:outline-none focus:ring-2 ring-offset-2 ring-offset-blue-400 ring-white ring-opacity-60',
              selected
                ? 'bg-indigo-500 bg-opacity-50 shadow'
                : 'text-blue-100 hover:bg-white/[0.12] hover:text-white',
            ]"
          >
            {{ category.tabName }}
          </button>
        </Tab>
      </TabList>
      <TabPanels
        class="bg-indigo-200 bg-opacity-50 rounded-md drop-shadow-lg px-4 py-2 my-2"
      >
        <TabPanel>
          <TripWiseDragList />
        </TabPanel>
        <TabPanel> table </TabPanel>
      </TabPanels>
    </TabGroup>
  </div>
</template>

<script lang="ts">
import { ref, defineComponent } from "vue";
import { TabGroup, TabList, Tab, TabPanels, TabPanel } from "@headlessui/vue";
import TripWiseDragList from "./TripWiseDragList.vue";
import Test from "./Test.vue";

export default defineComponent({
  name: "TripWiseTab",
  components: {
    TabGroup,
    TabList,
    Tab,
    TabPanels,
    TabPanel,
    TripWiseDragList,
  },
  setup() {
    let categories = ref({
      flightPlanner: {
        id: 1,
        tabName: "FlightPlanner",
        tabContent: "TripWiseDraggable",
      },
      costPlanning: {
        id: 2,
        tabName: "Cost Planning",
        tabContent: "table",
      },
    });

    return { categories };
  },
});
</script>
