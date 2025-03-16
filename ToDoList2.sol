// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ToDoList {
    struct ToDo {
        uint id;
        string content;
        bool completed;
    }

    mapping(uint => ToDo) public todos;
    uint public todosCount;

    constructor() {
        todosCount = 0;
    }

    // Create a new To-Do item
    function createToDo(string memory _content) public {
        todosCount++;
        todos[todosCount] = ToDo(todosCount, _content, false);
    }

    // Toggle the completion status of a To-Do item
    function toggleCompleted(uint _id) public {
        require(_id > 0 && _id <= todosCount, "To-Do ID is invalid.");
        ToDo storage toDo = todos[_id];
        toDo.completed = !toDo.completed;
    }

    // Delete a To-Do item
    function deleteToDo(uint _id) public {
        require(_id > 0 && _id <= todosCount, "To-Do ID is invalid.");
        delete todos[_id];
    }

    // Retrieve a specific To-Do item
    function getToDo(uint _id) public view returns (uint, string memory, bool) {
        require(_id > 0 && _id <= todosCount, "To-Do ID is invalid.");
        ToDo memory todo = todos[_id];
        return (todo.id, todo.content, todo.completed);
    }

    // Retrieve all To-Do items
    function getAllToDos() public view returns (ToDo[] memory) {
        ToDo[] memory allToDos = new ToDo[](todosCount);
        for (uint i = 1; i <= todosCount; i++) {
            allToDos[i - 1] = todos[i];
        }
        return allToDos;
    }

    // Retrieve only completed To-Dos
    function getCompletedToDos() public view returns (ToDo[] memory) {
        uint completedCount = 0;
        for (uint i = 1; i <= todosCount; i++) {
            if (todos[i].completed) {
                completedCount++;
            }
        }

        ToDo[] memory completedToDos = new ToDo[](completedCount);
        uint index = 0;
        for (uint i = 1; i <= todosCount; i++) {
            if (todos[i].completed) {
                completedToDos[index] = todos[i];
                index++;
            }
        }
        return completedToDos;
    }
}