const sampleReviews = [
  { name:'Asha Mendis', stars:5, text:'Absolutely loved my hair spa! Left feeling like a new person. The staff is so caring and professional.' },
  { name:'Priya N.', stars:5, text:'Best manicure I\'ve ever had in Colombo. The attention to detail is incredible. Will definitely come back!' },
  { name:'Shehan De Silva', stars:4, text:'Great facial treatment, very relaxing environment. Booking was easy and the stylist was very knowledgeable.' },
];

let userRating = 0;

// ── Render Reviews
function renderReviews() {
  const rg = document.getElementById('reviewsGrid');
  if(!rg) return;
  const all = JSON.parse(localStorage.getItem('reviews') || 'null') || sampleReviews;
  rg.innerHTML = all.map(r => `
    <div class="review-card">
      <div class="stars">${'★'.repeat(r.stars)}${'☆'.repeat(5-r.stars)}</div>
      <p class="review-text">${r.text}</p>
      <p class="reviewer">— ${r.name}</p>
    </div>`).join('');
}
document.addEventListener('DOMContentLoaded', renderReviews);

// ── Star Picker
document.addEventListener('DOMContentLoaded', () => {
    const stars = document.querySelectorAll('#starPicker span');
    stars.forEach(s => {
      s.addEventListener('click', () => {
        userRating = +s.dataset.v;
        stars.forEach((st,i) => st.classList.toggle('active', i < userRating));
      });
      s.addEventListener('mouseover', () => {
        stars.forEach((st,i) => st.classList.toggle('active', i <= +s.dataset.v-1));
      });
      s.addEventListener('mouseout', () => {
        stars.forEach((st,i) => st.classList.toggle('active', i < userRating));
      });
    });
});

function submitReview(){
  const name = document.getElementById('reviewName').value.trim();
  const text = document.getElementById('reviewText').value.trim();
  if(!name||!text||!userRating){ showToast('⚠️ Please fill all fields and select a rating.','#c0392b'); return; }
  const all = JSON.parse(localStorage.getItem('reviews') || 'null') || [...sampleReviews];
  all.unshift({name, stars:userRating, text});
  localStorage.setItem('reviews', JSON.stringify(all));
  renderReviews();
  document.getElementById('reviewName').value='';
  document.getElementById('reviewText').value='';
  userRating=0;
  const stars = document.querySelectorAll('#starPicker span');
  stars.forEach(s=>s.classList.remove('active'));
  showToast('✨ Thank you for your review!','#2a7a4f');
}

// ── Modal
function openModal(serviceId){
  if(serviceId) document.getElementById('modalService').value = serviceId;
  // Set min date to today
  const today = new Date().toISOString().split('T')[0];
  const modalDate = document.getElementById('modalDate');
  if(modalDate) modalDate.min = today;
  document.getElementById('bookingModal').classList.add('open');
}

function closeModal(){ document.getElementById('bookingModal').classList.remove('open'); }

function confirmBooking(){
  const svc = document.getElementById('modalService').value;
  const emp = document.getElementById('modalEmployee').value;
  const date = document.getElementById('modalDate').value;
  const time = document.getElementById('modalTime').value;
  const name = document.getElementById('modalName').value.trim();
  if(!svc||!emp||!date||!time||!name){ showToast('⚠️ Please fill in all booking details.','#c0392b'); return; }
  closeModal();
  showToast('🎉 Booking confirmed! See you soon, ' + name + '!','#2a7a4f');
}

// ── Toast
function showToast(msg, color='#2a7a4f'){
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.style.background = color;
  t.classList.add('show');
  setTimeout(()=>t.classList.remove('show'), 3500);
}

// Close modal on overlay click
document.addEventListener('click', e => {
  if(e.target.id==='bookingModal') closeModal();
});
