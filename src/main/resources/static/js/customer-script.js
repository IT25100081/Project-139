

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
