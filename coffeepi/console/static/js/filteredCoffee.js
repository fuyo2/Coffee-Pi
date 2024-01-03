document.addEventListener('DOMContentLoaded', function () {
    const brandLinks = document.querySelectorAll('#brandLinks a');
    const coffeeListDiv = document.getElementById('coffeeList');

    brandLinks.forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            const selectedBrand = this.textContent.trim(); // Get the brand name

            fetch(`/get_coffees_for_brand/?brand_name=${selectedBrand}`)
                .then(response => response.json())
                .then(data => {
                    console.log('Received data:', data); // Check the received data
                    coffeeListDiv.innerHTML = ''; // Clear previous content

                    data.coffees.forEach(coffee => {
                        // Create card elements
                        const cardDiv = document.createElement('div');
                        cardDiv.classList.add('card', 'mb-3', 'center-div-v');
                        cardDiv.style.maxWidth = '540px';

                        const rowDiv = document.createElement('div');
                        rowDiv.classList.add('row', 'g-0');

                        const colImgDiv = document.createElement('div');
                        colImgDiv.classList.add('col-md-4');

                        const img = document.createElement('img');
                        // Use Django static tag to handle the image path
                        img.src = coffee.trimmed_image_url; // Use trimmed_image_url property
                        img.classList.add('img-fluid', 'rounded-start');
                        img.alt = 'Coffee Image';

                        colImgDiv.appendChild(img);

                        const colBodyDiv = document.createElement('div');
                        colBodyDiv.classList.add('col-md-8');

                        const cardBodyDiv = document.createElement('div');
                        cardBodyDiv.classList.add('card-body');

                        const cardTitle = document.createElement('h5');
                        cardTitle.classList.add('card-title');
                        cardTitle.textContent = coffee.type;

                        const brandInfo = document.createElement('p');
                        brandInfo.classList.add('card-text');
                        brandInfo.innerHTML = `<small class="text-muted">${coffee.brand}</small>`;

                        const flavorInfo = document.createElement('p');
                        flavorInfo.classList.add('card-text');
                        flavorInfo.textContent = coffee.description;

                        const roastInfo = document.createElement('p');
                        roastInfo.classList.add('card-text');
                        roastInfo.innerHTML = `<small class="text-muted">${coffee.roast}</small>`;

                        const selectBtn = document.createElement('a');
                        selectBtn.href = '#'; // Set the button link
                        selectBtn.classList.add('btn', 'btn-primary');
                        selectBtn.textContent = 'Select This Coffee';

                        cardBodyDiv.appendChild(cardTitle);
                        cardBodyDiv.appendChild(brandInfo);
                        cardBodyDiv.appendChild(flavorInfo);
                        cardBodyDiv.appendChild(roastInfo);
                        cardBodyDiv.appendChild(selectBtn);

                        colBodyDiv.appendChild(cardBodyDiv);
                        rowDiv.appendChild(colImgDiv);
                        rowDiv.appendChild(colBodyDiv);
                        cardDiv.appendChild(rowDiv);

                        coffeeListDiv.appendChild(cardDiv); // Append the card to the container
                    });
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                });
        });
    });
});
