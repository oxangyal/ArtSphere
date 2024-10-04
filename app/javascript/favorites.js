document.addEventListener("DOMContentLoaded", function() {
    const favoriteToggles = document.querySelectorAll('.favorite-toggle');

    favoriteToggles.forEach(toggle => {
      toggle.addEventListener('click', function(event) {
        event.preventDefault(); // Prevent the default link action
        const icon = this.querySelector('.favorite-icon');

        // Make the AJAX request to favorite/unfavorite the product
        const url = this.getAttribute('href');
        const method = this.getAttribute('data-method') || 'post';

        fetch(url, {
          method: method,
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            'Content-Type': 'application/json',
          }
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json(); // Expecting a JSON response with the updated favorite status
        })
        .then(data => {
          // Update the heart icon based on the updated favorite status
          const iconId = 'favorite-icon-' + data.product_id; // Use the product's id
          const iconElement = document.getElementById(iconId);

          if (data.favorited) {
            iconElement.classList.remove('far');
            iconElement.classList.add('fas', 'text-red-500');
            iconElement.setAttribute('data-favorited', 'true');
          } else {
            iconElement.classList.remove('fas', 'text-red-500');
            iconElement.classList.add('far', 'text-gray-500');
            iconElement.setAttribute('data-favorited', 'false');
          }
        })
        .catch(error => console.error('Error:', error));
      });
    });
  });
