const response = fetch("/")
    .then(data => data.json())
    .then(data => {
        const counter = document.getElementById("page-views");
        counter.innerText = `👣 Digital Footprints: ${data} page views.`;
    });
