<template >
  <input type="text" id="input" name="input" v-model="input" @keydown.enter="submit">
  <button @click="submit"><slot>{{ text }}</slot></button>
</template>


<script setup>
  const props = defineProps(['answer', 'next_page', 'text'])
  const input = ref('')
  const router = useRouter()
  const text = ref(props.text ? props.text : "Enviar")

  function submit() {
    if (input.value.toLowerCase() == props.answer.toLowerCase()) 
      router.push(props.next_page)
  }

</script>
