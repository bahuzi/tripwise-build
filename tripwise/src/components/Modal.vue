<template>
  <TransitionRoot appear :show="visible" as="template">
    <Dialog as="div" @close="closeModal">
      <div class="fixed inset-0 z-10 overflow-y-auto">
        <div class="min-h-screen px-4 text-center">
          <TransitionChild
            as="template"
            enter="duration-300 ease-out"
            enter-from="opacity-0"
            enter-to="opacity-100"
            leave="duration-200 ease-in"
            leave-from="opacity-100"
            leave-to="opacity-0"
          >
            <DialogOverlay
              class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"
            />
          </TransitionChild>

          <span class="inline-block h-screen align-middle" aria-hidden="true">
            &#8203;
          </span>

          <TransitionChild
            as="template"
            enter="duration-300 ease-out"
            enter-from="opacity-0 scale-95"
            enter-to="opacity-100 scale-100"
            leave="duration-200 ease-in"
            leave-from="opacity-100 scale-100"
            leave-to="opacity-0 scale-95"
          >
            <div
              class="inline-block w-full max-w-4xl p-6 my-8 text-left align-middle transition-all transform bg-white shadow-xl rounded-2xl"
            >
              <button @click="closeModal" class="absolute top-3 right-3">
                <XIcon class="h-4 w-4" />
              </button>
              <DialogTitle
                as="h3"
                class="text-lg font-bold text-gray-900 uppercase text-center p-4"
              >
                {{ modalData.action }} Activity
              </DialogTitle>
              <TripWiseSelect :modalData="modalData" @on-modal="onModal"/>
            </div>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script lang="ts">
import { ref, defineComponent } from "vue";
import { XIcon } from "@heroicons/vue/outline";
import TripWiseSelect from "./TripWiseSelect.vue";

import {
  TransitionRoot,
  TransitionChild,
  Dialog,
  DialogOverlay,
  DialogTitle,
} from "@headlessui/vue";

export default defineComponent({
  props: ["visible", "modalData"],
  name: "Modal",
  components: {
    TransitionRoot,
    TransitionChild,
    Dialog,
    DialogOverlay,
    DialogTitle,
    TripWiseSelect,
    XIcon,
  },
  setup(props, context) {
    function onModal(val: string): void {
     context.emit("onModal", val);
    }
    function closeModal() {
      context.emit("onModal", "cancel");
    }
    return {
      closeModal,
      onModal
    };
  },
});
</script>
