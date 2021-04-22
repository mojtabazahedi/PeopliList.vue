<template>
    <li :class="{editing:isEditing}">
        <button class="button" @click="$emit('delete-me')">Clear</button>
         <span class="view" @dblclick="editMe">{{ localFirstname }}</span>
         <span class="view" @dblclick="editMe">{{ localLastname }}</span>
         <input class="edit" v-model="localFirstname" @blur="saveMe" ref="input1">
         <input class="edit" v-model="localLastname" @blur="saveMe" ref="input2">
    </li>
</template>

<script>

export default {
    props: ['firstname', 'lastname'],
    data() {
        return{
            isEditing: false,
            localFirstname: this.firstname,
            localLastname: this.lastname
        }
    },
    methods: {
        editMe() {
            this.isEditing = true;
            this.$nextTick(() => this.$refs.any.focus());
        },
        saveMe(){
            this.isEditing = false;
            this.$emit('save-me', this.localFirstname, this.localLastname);
            
        }
    }

}
</script>

<style scoped>
    .edit {
        display: none;
    }

    li.editing .edit {
        display: inline;
        border-radius: 3px;
    }

    li.editing .view {
        display: none;
    }

    .button{
        color: rgb(243, 6, 6);
        border-radius: 3px;
    }
    
</style>
