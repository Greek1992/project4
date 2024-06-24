const apiBasis = "http://127.0.0.1:8000/api/items/"
const apiAchievements = apiBasis + "achievements"
const apiExercises = apiBasis + "exercises"
const apiUsers = apiBasis + "users"
const apiAchievementExercises = apiBasis + "achievements/exercises/"
const apiAchievementUsers = apiBasis + "achievements/users/"

let loggedIn = false; // Variable to track login status

function toggleForm() {
    var formContainer = document.getElementById("formContainer");
    var toggleButton = document.getElementById("toggleButton");

    if (formContainer.style.display === "none" || formContainer.style.display === "") {
        formContainer.style.display = "block";
        toggleButton.textContent = "Hide Forms";
    } else {
        formContainer.style.display = "none";
        toggleButton.textContent = "Show Forms";
    }
}

async function AddExercise() {
    const name = document.querySelector('#nameForm').value;
    const instructionEN = document.querySelector('#instructionForm').value;
    const instructieNL = document.querySelector('#instructieForm').value;

    if (!name || !instructionEN || !instructieNL) {
        alert('Please fill in all fields.');
        return;
    }

    const exerciseData = {
        name: name,
        instructionEN: instructionEN,
        instructieNL: instructieNL
    };

    const token = localStorage.getItem('token');
    const config = {
        headers: {
            Authorization: `Bearer ${token}`
        }
    };

    try {
        const response = await axios.post('http://127.0.0.1:8000/api/items/exercises', exerciseData, config);
        if (response.status === 201) {
            alert('Exercise added successfully!');
            // Optionally, update UI or reload data after adding exercise
            laad(); // Reloads all data after adding exercise
            // Clear input fields after successful addition
            document.querySelector('#nameForm').value = '';
            document.querySelector('#instructionForm').value = '';
            document.querySelector('#instructieForm').value = '';
        } else {
            alert('Failed to add exercise.');
        }
    } catch (error) {
        console.error('Error adding exercise:', error);
        alert('Error adding exercise.');
    }
}

async function deleteAchievement(id) {
    try {
        const token = localStorage.getItem('token');
        const config = {
            headers: { Authorization: `Bearer ${token}` }
        };

        const response = await axios.delete(`${apiBasis}achievements/${id}`, config);

        if (response.status === 200) {
            alert('Achievement deleted successfully!');
            // Optionally, update UI or reload data after deletion
            laad(); // This will reload all data after deletion
        } else {
            alert('Failed to delete achievement.');
        }
    } catch (error) {
        console.error('Error deleting achievement:', error);
        alert('Error deleting achievement.');
    }
}

async function deleteExercise(id) {
    try {
        const token = localStorage.getItem('token');
        const config = {
            headers: { Authorization: `Bearer ${token}` }
        };

        const response = await axios.delete(`${apiBasis}exercises/${id}`, config);

        if (response.status === 200) {
            alert('Exercise deleted successfully!');
            // Optionally, update UI or reload data after deletion
            laad(); // This will reload all data after deletion
        } else {
            alert('Failed to delete exercise.');
        }
    } catch (error) {
        console.error('Error deleting exercise:', error);
        alert('Error deleting exercise.');
    }
}

async function deleteUser(id) {
    try {
        const token = localStorage.getItem('token');
        const config = {
            headers: { Authorization: `Bearer ${token}` }
        };

        const response = await axios.delete(`${apiBasis}users/${id}`, config);

        if (response.status === 200) {
            alert('user deleted successfully!');
            // Optionally, update UI or reload data after deletion
            laad(); // This will reload all data after deletion
        } else {
            alert('Failed to delete user.');
        }
    } catch (error) {
        console.error('Error deleting user:', error);
        alert('Error deleting user.');
    }
}

const laad = async () => 
{
    console.log('Laad gegevens');
    const response1 = await axios.get(apiAchievements); const achievements = await response1.data;
    const response2 = await axios.get(apiExercises); const exercises = await response2.data;
    const response3 = await axios.get(apiUsers); const users = await response3.data;
    const response4 = await axios.get(apiAchievementExercises); const achievementexercises = await response4.data;
    const response5 = await axios.get(apiAchievementUsers); const achievementusers = await response5.data;

    let userInhoud = '';
    for (const el of users)
    {
        userInhoud += `<tr><td>${el.id}</td><td>${el.name}</td><td>${el.role}</td><td>${el.email}</td><td><button class="deleteButton" style="color: red; display: none;" onclick="deleteUser(${el.id})">X</button></td></tr>`;
    }
    document.querySelector("#userInhoud").innerHTML = userInhoud;

    let exercisesInhoud = '';
    for (const el of exercises)
    {
        exercisesInhoud += `<tr><td>${el.id}</td><td>${el.name}</td><td>${el.instructionEN}</td><td>${el.instructieNL}</td><td><button class="deleteButton" style="color: red; display: none;" onclick="deleteExercise(${el.id})">X</button></td></tr>`;
    }
    document.querySelector("#exercisesInhoud").innerHTML = exercisesInhoud;

    let achievementsInhoud = '';
    for (const el of achievements)
    {
        achievementsInhoud += `<tr><td>${el.id}</td><td>${el.exerciseID}</td><td>${el.userID}</td><td>${el.datum}</td><td>${el.amount}</td><td><button class="deleteButton" style="color: red; display: none;" onclick="deleteAchievement(${el.id})">X</button></tr>`;
    }
    document.querySelector("#achievementsInhoud").innerHTML = achievementsInhoud;

    updateUI();
}


async function login() {
    const email = document.querySelector('#loginEmail').value;
    const password = document.querySelector('#loginPassword').value;

    if (!email || !password) {
        alert('Please enter both email and password.');
        return;
    }

    const loginData = { email: email, password: password };

    try {
        const response = await axios.post('http://127.0.0.1:8000/api/login', loginData);
        if (response.data.access_token) {
            localStorage.setItem('token', response.data.access_token);
            console.log('Token:', response.data.access_token);
            alert('Login successful!');
            loggedIn = true;
            updateUI();
        } else {
            alert('Login failed.');
        }
    } catch (error) {
        console.error('Error during login:', error);
        alert('Error during login.');
    }
}

async function register() {
    const name = document.querySelector('#registerName').value;
    const email = document.querySelector('#registerEmail').value;
    const role = "beheerder";
    const password = document.querySelector('#registerPassword').value;
    const confirmPassword = document.querySelector('#registerConfirmPassword').value;

    if (!name || !email || !role ||  !password || !confirmPassword) {
        alert('Vul alle velden in');
        return;
    }

    if (password !== confirmPassword) {
        alert('Wachtwoorden zijn niet gelijk');
        return;
    }

    const registerData = { name: name, email: email, role: role, password: password, password_confirmation: confirmPassword };

    console.log(registerData);

    try {
        const response = await axios.post('http://127.0.0.1:8000/api/register', registerData);
        if (response.data.message === 'Registration successful') {
            alert('Registration successful! You can now login.');
            // Redirect or perform other actions after successful registration
        } else {
            alert('Registration failed.');
        }
    } catch (error) {
        console.error('Error during registration:', error);
        alert('Error during registration.');
    }
}

function logout() {
    localStorage.removeItem('token');
    alert('Logged out successfully!');
    loggedIn = false;
    updateUI();
    window.location.href = 'eindopdrachtCRUD.html';
}

function updateUI() {
    const logoutButton = document.getElementById('logoutButton');
    const exerciseForm = document.getElementById('exerciseForm');
    const deleteButton = document.getElementsByClassName('deleteButton');

    if (loggedIn) {
        logoutButton.style.display = 'block';
        exerciseForm.style.display = 'block';
        for(var i = 0; i < deleteButton.length; i++)
            {
                deleteButton[i].style.display = 'block';
            }
    } else {
        logoutButton.style.display = 'none';
        exerciseForm.style.display = 'none';
        for(var i = 0; i < deleteButton.length; i++)
            {
                deleteButton[i].style.display = 'none';
            }
    }
}

window.onload = laad;