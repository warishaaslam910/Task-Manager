# Flutter Task Manager App

A **Task Manager** Flutter application demonstrating Clean Architecture, state management with Cubit/BLoC, local caching, and integration with a dummy API (DummyJSON). Users can authenticate, view, add, update, and delete tasks.

---

## **Table of Contents**

- [Overview](#overview)  
- [Features](#features)  
- [Architecture & Project Structure](#architecture--project-structure)  
- [State Management Approach](#state-management-approach)  
- [Setup & Installation](#setup--installation)  
- [Usage](#usage)  
- [Challenges Faced](#challenges-faced)  
- [Future Improvements](#future-improvements)  

---

## **Overview**

This project is a small-scale Task Manager app built using Flutter. It focuses on:

- Clean Architecture  
- Cubit/BLoC state management  
- API integration with DummyJSON  
- Offline caching with SharedPreferences  
- Modular and reusable UI components  

The goal was to demonstrate Flutter development best practices, separation of concerns, and maintainable code structure.

---

## **Features**

- User authentication (login only) using DummyJSON Auth API.  
- View task list with pagination.  
- Add new tasks locally (simulated API).  
- Update tasks (mark completed or edit title).  
- Delete tasks (simulated API).  
- Offline caching of tasks using SharedPreferences.  
- Modern, reusable UI components.  
- Bloc/Cubit state management for predictable and testable states.  

---

## **Architecture & Project Structure**

The project follows **Clean Architecture** principles:


- **Core Layer**: Networking, local storage, routing.  
- **Features Layer**: Split by modules (`auth` and `tasks`) each with its **data**, **cubit**, and **presentation** layers.  
- **Repositories**: Handle business logic and data caching.  
- **Cubit & State**: Manages reactive state and updates UI.  

---

## **State Management Approach**

- **Cubit/BLoC** used for each feature (`AuthCubit` and `TaskCubit`).  
- **AuthCubit** handles login, logout, and session state.  
- **TaskCubit** handles fetching tasks, pagination, adding, updating, and deleting tasks.  
- Separation of **Cubit** and **State** allows testable and predictable updates.  

---

## **Challenges / Issues Faced**

1-Dummy API Limitations

DummyJSON API does not persist POST, PUT, DELETE requests.

Adding, updating, or deleting tasks only simulates changes and does not reflect on the server.

2-State Management

Ensuring Cubit emitted correct states after login, task addition, update, or delete.

Managing updates in the UI when tasks changed.

## **Setup & Installation**

1. **Clone the repository**

```bash
git clone <your-repo-url>
cd flutter_task_manager



