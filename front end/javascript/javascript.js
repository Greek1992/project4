const apiBasis = "http://127.0.0.1:8000/api/items/"
const apiAchievements = apiBasis + "achievements"
const apiExercises = apiBasis + "exercises"
const apiUsers = apiBasis + "users"
const apiAchievementExercises = apiBasis + "achievements/exercises/"
const apiAchievementUsers = apiBasis + "achievements/users/"

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
        userInhoud += `<tr><td>${el.id}</td><td>${el.name}</td><td>${el.role}</td><td>${el.email}</td></tr>`;
    }
    document.querySelector("#userInhoud").innerHTML = userInhoud;

    let exercisesInhoud = '';
    for (const el of exercises)
    {
        exercisesInhoud += `<tr><td>${el.id}</td><td>${el.name}</td><td>${el.instructionEN}</td><td>${el.instructieNL}</td></tr>`;
    }
    document.querySelector("#exercisesInhoud").innerHTML = exercisesInhoud;

    let achievementsInhoud = '';
    for (const el of achievements)
    {
        achievementsInhoud += `<tr><td>${el.id}</td><td>${el.exerciseID}</td><td>${el.userID}</td><td>${el.datum}</td><td>${el.amount}</td></tr>`;
    }
    document.querySelector("#achievementsInhoud").innerHTML = achievementsInhoud;
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
            document.getElementById('logoutButton').style.display = 'block';
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

function logout() 
{
    localStorage.removeItem('token');
    alert('Logged out successfully!');
    window.location.href = 'eindopdrachtCRUD.html';
}