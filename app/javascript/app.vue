<template>
  <div id="app">
    <ul>
      <div  class="empty" v-if="!entryData.length">The List is Empty</div>
      <my-li v-for="(data, index) in entryData" 
      :key="data.id"
      :firstname="data.firstname"
      :lastname="data.lastname"
      @delete-me="clearData(index)"
      @save-me="updateData(index, $event)">
      </my-li>
    </ul>

    <input class="input" v-model="firstnames" placeholder="First Name"><br>
    <input class="input" v-model="lastnames" placeholder="Last Name"><br>
    <button class="button" @click="saveData">Add</button> 
   
  </div>
</template>

<script>
import axios from 'axios';
import MyLi from './packs/components/MyLi.vue';
const API_URL = '/api/people';
export default {
  data() {
    return {
      firstnames: '',
      lastnames: '',
      entryData: []
     
    }
  },
  methods: {
    saveData() {
      axios.post(API_URL,{
        firstname: this.firstnames,
        lastname: this.lastnames
      })
      .then(response => {this.loadData();})
      .catch(e => {console.log(e)});
      this.firstnames = '';
      this.lastnames = '';
    },

    clearData(i) {
      let id = this.entryData[i].id;
      axios.delete(API_URL+'/'+id)
      .then(response => {this.loadData();})
      .catch(e => {console.log(e)});
    },

    updateData(i, firstname, lastname){
      let entry = this.entryData[i];
      entry.firstname = firstname;
      entry.lastname = lastname;
      axios.put(API_URL+'/'+entry.id, entry)
      .then(response => {this.loadData();})
      .catch(e => {console.log(e)});
    },

    loadData() {
      axios.get(API_URL)
      .then(response => {this.entryData = response.data;})
      .catch(e => {console.log(e)});
    }

  },
  mounted() {
    this.loadData();
  },
  components: {
    MyLi
  }
}
</script>

<style scoped>
  .input{
    border-radius: 3px;
    text-align: center;
    margin-top: 2px;
  }

  .button{
    color: rgb(23, 60, 180);
    border-radius: 3px;
    margin-top: 2px;

  }

  .empty{
    color: orangered;
    font-weight: bold;
  }
</style>
