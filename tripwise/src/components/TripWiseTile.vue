<template>
  <div v-for="(section, key) in sections" :key="section.key">
    <div
      class="rounded-lg mx-2 p-4 bg-indigo-100 bg-opacity-75 shadow-lg space-y-3 cursor-move h-40 w-70 hover:bg-indigo-50 hover:bg-opacity-30"
      @mouseover="mousePosition(element.id, key)"
      @mouseleave="hover = false"
      :id="element.id + -+key"
    >
      <div class="flex flex-col space-y-5">
        <div class="flex flex-row">
          <h3 class="flex-grow font-semibold truncate text-ms">
            {{ section.title }} {{ element[section.key] }}
          </h3>
          <button
            class="flex-grow-0 mr-3"
            v-show="showButton(element.id, key)"
            @click="edit"
          >
            <PencilIcon class="h-4 w-4" />
          </button>
          <button
            class="flex-grow-0"
            v-show="showButton(element.id, key)"
            @click="remove"
          >
            <XIcon class="h-4 w-4" />
          </button>
        </div>

        <p class="text-xs pb-1">{{ section.key }}</p>
        <p class="text-xs pb-1">key: {{ key }}</p>
        <button
          class="flex justify-center"
          v-show="showButton(element.id, key)"
          @click="add"
        >
          <ChevronDoubleDownIcon
            class="animate__animated animate__bounce item-center h-5 w-5"
          />
        </button>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { ref, defineComponent } from "vue";
import Modal from "./types/Modal";
import {
  XIcon,
  ChevronDoubleDownIcon,
  PencilIcon,
} from "@heroicons/vue/outline";

export default defineComponent({
  props: ["element"],
  name: "TripWiseDragTile",
  components: {
    XIcon,
    ChevronDoubleDownIcon,
    PencilIcon,
  },
  emits: ["act"],
  setup(props, context) {
    const sections = ref([
      { title: "Date", key: "date" },
      { title: "Origin", key: "origin" },
      { title: "Destination", key: "destination" },
      { title: "Flight Number", key: "flightNumber" },
      { title: "Cost", key: "price" },
    ]);
    const payload = ref<Modal>({
      action: "none",
      listId: "null",
      id: "null",
    });
    const hover = ref(false);
    let positionX = 0;
    let positionY = 0;

    function remove() {
      payload.value.action = "remove";
      payload.value.listId = props.element.id;
      context.emit("act", payload.value);
    }
    function edit() {
      payload.value.action = "edit";
      payload.value.listId = props.element.id;
      context.emit("act", payload.value);
    }
    function add() {
      payload.value.action = "add";
      payload.value.listId = props.element.id;
      context.emit("act", payload.value);
    }
    function mousePosition(x: number, y: number) {
      positionX = x;
      positionY = y;
      hover.value = true;
    }
    function showButton(x: number, y: number) {
      if (hover.value == true && x == positionX && y == positionY) return true;
    }
    return {
      sections,
      hover,
      remove,
      edit,
      add,
      mousePosition,
      showButton,
    };
  },
});
</script>
