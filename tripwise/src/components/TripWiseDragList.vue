<template>
  <modal :visible="visible" :modalData="modalData" @on-modal="onModal" />
  <draggable
    :list="list"
    tag="transition-group"
    :component-data="{ tag: 'ul', name: 'flip-list' }"
    group="flightPlanner"
    class="p-5"
    item-key="id"
    :animation="300"
    ghost-class="ghost"
    @start="dragging = true"
    @end="dragging = false"
  >
    <template #item="{ element }">
      <li class="grid grid-cols-5 py-2" :key="element.id" :id="element.id">
        <TripWiseTile @act="act" :element="element" />
      </li>
    </template>
  </draggable>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import draggable from "vuedraggable";
import TripWiseTile from "./TripWiseTile.vue";
import sampleData from "./data/sample.json";
import modal from "./Modal.vue";
import ModalType from "./types/Modal";
export default defineComponent({
  name: "TripWiseDragList",
  components: {
    modal,
    draggable,
    TripWiseTile,
  },
  setup() {
    const list = ref(sampleData);
    const dragging = false;
    const modalData = ref({
      id: 1,
      visible: false,
      listId: "",
      action: "",
      data: {},
    });
    const visible = ref(false);
    function act(val: ModalType): void {
      modalData.value.visible = true;
      modalData.value.listId = val.listId;
      modalData.value.action = val.action;
      modalData.value.data = list.value.filter(
        (row: { id: string }) => row.id == val.listId
      )[0];
      visible.value = true;
    }
    function remove(listId: string): void {
      list.value = list.value.filter(
        (row: { id: string }) => row.id !== listId
      );
    }
    function add(listId: string): void {
      let tmpData = list.value.filter(
        (row: { id: string }) => row.id == listId
      )[0];
      let addedObject = {
        id: "0",
        date: tmpData.date,
        location: tmpData.destination,
        origin: tmpData.destination,
        destination: "",
        flightNumber: "",
        flightStartAt: tmpData.flightEndAt,
        flightEndAt: tmpData.flightEndAt,
        name: "Wei Wang",
        price: 0,
        priceCombo: [1, 2],
      };
      list.value.splice(parseInt(listId), 0, addedObject);
      console.log(modalData.value.data);
    }
    function edit(listId: string): void {
      modalData.value.data = list.value.filter(
        (row: { id: string }) => row.id == listId
      );
    }
    function onModal(val: string): void {
      visible.value = false;
      if (val === "confirmed" && modalData.value.action === "remove") {
        remove(modalData.value.listId);
        modalData.value.visible = false;
        modalData.value.listId = "";
      }
      if (val === "confirmed" && modalData.value.action === "add") {
        add(modalData.value.listId);
        modalData.value.visible = false;
        modalData.value.listId = "";
      }
      if (val === "confirmed" && modalData.value.action === "edit") {
        edit(modalData.value.listId);
        modalData.value.visible = false;
        modalData.value.listId = "";
      }
    }
    return {
      list,
      dragging,
      visible,
      modalData,
      act,
      onModal,
    };
  },
});
</script>

<style scoped>
.ghost {
  opacity: 0.5;
  background: #e9d1f5;
}
.flip-list-move {
  transition: transform 1s;
}
</style>
