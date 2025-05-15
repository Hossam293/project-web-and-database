document.addEventListener('DOMContentLoaded', () => {
    const table = document.querySelector('table');
    const add = document.querySelector('#add');
    const mainSection = document.querySelector('#main-section');
    const formSection = document.querySelector('#form-section');
    const id = document.getElementById('id');
    const title = document.getElementById('title');
    const body = document.getElementById('body');
    const submit = document.querySelector('#submit');

    let currentPostId = null;
    let posts = [];

    async function fetchData() {
        try {
            const response = await fetch('https://jsonplaceholder.typicode.com/posts');
            const data = await response.json();
            posts = data;
            displayData();
        } catch (error) {
            alert('Failed to load posts');
            posts = [];
            displayData();
        }
    }

    function displayData() {
        table.querySelectorAll('tr:not(:first-child)').forEach(row => row.remove());

        posts.forEach(post => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${post.id}</td>
                <td>${post.title}</td>
                <td>${post.body}</td>
                <td>
                    <button class="update-btn" data-id="${post.id}">Update</button>
                    <button class="delete-btn" data-id="${post.id}">Delete</button>
                </td>
            `;
            table.appendChild(row);
        });

        document.querySelectorAll('.update-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                const idValue = parseInt(btn.getAttribute('data-id'));
                const post = posts.find(p => p.id === idValue);
                showFormWithData(idValue, encodeURIComponent(post.title), encodeURIComponent(post.body));
            });
        });

        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                const postId = parseInt(btn.getAttribute('data-id'));
                deletePost(postId);
            });
        });
    }

    async function deletePost(postId) {
        const index = posts.findIndex(post => post.id === postId);
        if (index === -1) {
            alert('Post not found with ID: ' + postId);
            return;
        }

        try {
            const response = await fetch(`https://jsonplaceholder.typicode.com/posts/${postId}`, {
                method: 'DELETE',
            });

            posts.splice(index, 1);
            displayData();
        } catch (error) {
            alert(error.message || 'An error occurred while deleting the post');
        }
    }

    add.addEventListener('click', () => {
        mainSection.style.display = 'none';
        formSection.style.display = 'block';
        id.value = '';
        title.value = '';
        body.value = '';
        currentPostId = null;
    });

    window.showFormWithData = function(idValue, titleValue, bodyValue) {
        mainSection.style.display = 'none';
        formSection.style.display = 'block';
        id.value = idValue;
        title.value = decodeURIComponent(titleValue);
        body.value = decodeURIComponent(bodyValue);
        currentPostId = idValue;
    };

    async function submitPost(data, isUpdate) {
        try {
            const url = isUpdate 
                ? `https://jsonplaceholder.typicode.com/posts/${data.id}`
                : 'https://jsonplaceholder.typicode.com/posts';
            const method = isUpdate ? 'PUT' : 'POST';

            const response = await fetch(url, {
                method: method,
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data),
                signal: AbortSignal.timeout(5000)
            });


            const result = await response.json();

            if (isUpdate) {
                const index = posts.findIndex(post => post.id === data.id);
                if (index !== -1) {
                    posts[index] = data;
                } else {
                    return false;
                }
            } else {
                if (posts.some(post => post.id === parseInt(data.id))) {
                    alert('ID already exists. Please use a different ID.');
                } else {
                    posts.push(data);
                }
            }
            return true;
        } catch (error) {
            alert(error.message || 'An error occurred during submission');
            return false;
        } finally {
            showMainSection();
        }
    }

    submit.addEventListener('click', async () => {
        if (!id.value || !title.value || !body.value) {
            alert('Please fill in all fields');
            return;
        }

        const postData = {
            id: parseInt(id.value),
            title: title.value,
            body: body.value
        };

        const isUpdate = !!currentPostId;
        await submitPost(postData, isUpdate);
    });

    function showMainSection() {
        mainSection.style.display = 'block';
        formSection.style.display = 'none';
        displayData();
    }

    fetchData();
});
