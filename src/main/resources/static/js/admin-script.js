/* â•â•â• DATA â•â•â• */
let users = [
  {id:1,name:'Asha Mendis',email:'asha@email.com',phone:'+94 71 123 4567',status:'Active',joined:'2025-01-12'},
  {id:2,name:'Priya Navaratne',email:'priya@email.com',phone:'+94 77 234 5678',status:'Active',joined:'2025-02-08'},
  {id:3,name:'Shehan De Silva',email:'shehan@email.com',phone:'+94 76 345 6789',status:'Inactive',joined:'2025-03-20'},
  {id:4,name:'Malini Rajapaksa',email:'malini@email.com',phone:'+94 71 456 7890',status:'Active',joined:'2025-04-05'},
  {id:5,name:'Tharuki Wijesinghe',email:'tharuki@email.com',phone:'+94 78 567 8901',status:'Active',joined:'2025-04-18'},
];
let appointments = [
  {id:1,customer:'Asha Mendis',service:'Hair Spa Treatment',stylist:'Kamala Silva',date:'2025-05-14',time:'10:00',status:'Confirmed'},
  {id:2,customer:'Priya Navaratne',service:'Luxury Manicure',stylist:'Ravi Fernando',date:'2025-05-14',time:'14:00',status:'Pending'},
  {id:3,customer:'Shehan De Silva',service:'Glow Facial',stylist:'Dilani Jayasinghe',date:'2025-05-15',time:'11:00',status:'Confirmed'},
  {id:4,customer:'Malini Rajapaksa',service:'Precision Haircut',stylist:'Nimal Perera',date:'2025-05-15',time:'09:00',status:'Pending'},
  {id:5,customer:'Tharuki Wijesinghe',service:'Hair Colouring',stylist:'Nimal Perera',date:'2025-05-16',time:'13:00',status:'Cancelled'},
  {id:6,customer:'Asha Mendis',service:'Pedicure Bliss',stylist:'Kamala Silva',date:'2025-05-17',time:'15:00',status:'Pending'},
];
let staff = [
  {id:1,name:'Nimal Perera',spec:'Hair Specialist',phone:'+94 71 234 5678',email:'nimal@gh.lk',exp:8,status:'Active'},
  {id:2,name:'Kamala Silva',spec:'Skin Care Expert',phone:'+94 77 345 6789',email:'kamala@gh.lk',exp:5,status:'Active'},
  {id:3,name:'Ravi Fernando',spec:'Nail Artist',phone:'+94 76 456 7890',email:'ravi@gh.lk',exp:4,status:'Active'},
  {id:4,name:'Dilani Jayasinghe',spec:'Beauty Therapist',phone:'+94 71 567 8901',email:'dilani@gh.lk',exp:6,status:'On Leave'},
];
let admins = [
  {id:1,name:'Admin User',email:'admin@beautysalon.lk',role:'Super Admin',status:'Active',lastLogin:'2025-05-12'},
  {id:2,name:'Sanduni Manager',email:'sanduni@beautysalon.lk',role:'Manager',status:'Active',lastLogin:'2025-05-11'},
];
let reviews = [
  {name:'Asha Mendis',stars:5,text:'Absolutely loved my hair spa! Left feeling like a new person.',date:'2025-05-10'},
  {name:'Priya N.',stars:5,text:'Best manicure in Colombo. Attention to detail is incredible.',date:'2025-05-09'},
  {name:'Shehan D.',stars:4,text:'Very relaxing, great environment. Booking was easy.',date:'2025-05-08'},
  {name:'Malini R.',stars:3,text:'Service was good but waiting time was a bit long.',date:'2025-05-07'},
  {name:'Tharuki W.',stars:5,text:'The hair colouring came out exactly as I wanted!',date:'2025-05-06'},
];
let services = [
  {id:1,name:'Precision Haircut',price:800,desc:'Expert cut & style tailored to your face shape.',img:''},
  {id:2,name:'Hair Spa Treatment',price:2500,desc:'Deep conditioning therapy to restore shine.',img:''},
  {id:3,name:'Hair Colouring',price:4500,desc:'Full colour, highlights, balayage.',img:''},
  {id:4,name:'Glow Facial',price:3000,desc:'Custom facial to hydrate and revive dull skin.',img:''},
  {id:5,name:'Luxury Manicure',price:1200,desc:'Nail shaping, cuticle care, vibrant polish.',img:''},
  {id:6,name:'Pedicure Bliss',price:1500,desc:'Foot soak, scrub and pamper from heel to toe.',img:''},
];

let svcIdCtr=services.length+1, userIdCtr=users.length+1, apptIdCtr=appointments.length+1;
let staffIdCtr=staff.length+1, adminIdCtr=admins.length+1;
let apptFilter='all', reviewFilter=0;
let selectedImageData='';
let svcViewMode='grid';

/* â•â•â• SIDEBAR â•â•â• */
function toggleDesktopSidebar() {
  const sb = document.getElementById('sidebar');
  const mn = document.getElementById('mainContent');
  sb.classList.toggle('mini');
  mn.classList.toggle('sidebar-mini');
}
function toggleMobileSidebar() {
  document.getElementById('sidebar').classList.add('mobile-open');
  document.getElementById('sidebarOverlay').style.display='block';
}
function closeMobileSidebar() {
  document.getElementById('sidebar').classList.remove('mobile-open');
  document.getElementById('sidebarOverlay').style.display='none';
}

/* â•â•â• NAVIGATION â•â•â• */
function go(id, el) {
  document.querySelectorAll('.page').forEach(p=>p.classList.remove('active'));
  document.querySelectorAll('.nav-item').forEach(n=>n.classList.remove('active'));
  document.getElementById('page-'+id).classList.add('active');
  const titles = {
    dashboard:'Dashboard', users:'User Management', appointments:'Appointment Management',
    services:'Service Management', staff:'Staff / Stylist Management',
    admins:'Admin Management', feedback:'Feedback & Reviews'
  };
  document.getElementById('pageTitle').textContent = titles[id] || id;
  if(el) el.classList.add('active');
  const renders = {
    dashboard:renderDashboard, users:renderUsers, appointments:renderAppts,
    services:renderServices, staff:renderStaff, admins:renderAdmins, feedback:renderFeedback
  };
  if(renders[id]) renders[id]();
  // close mobile sidebar on nav
  if(window.innerWidth<=768) closeMobileSidebar();
}

/* â•â•â• DASHBOARD â•â•â• */
function renderDashboard() {
  const days=['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
  const vals=[8,12,10,15,20,28,17];
  const mx=Math.max(...vals);
  document.getElementById('dashChart').innerHTML=days.map((d,i)=>`
    <div class="bar-col">
      <div class="bar" style="height:${Math.round((vals[i]/mx)*105)}px"></div>
      <div class="bar-lbl">${d}</div>
    </div>`).join('');

  document.getElementById('topStylists').innerHTML=staff.map(s=>`
    <div style="display:flex;justify-content:space-between;align-items:center;padding:0.55rem 0;border-bottom:1px solid var(--border);">
      <div style="display:flex;align-items:center;gap:0.6rem;">
        <div style="width:32px;height:32px;border-radius:9px;background:var(--rose-soft);display:flex;align-items:center;justify-content:center;font-size:0.68rem;font-weight:700;color:var(--rose);">
          ${s.name.split(' ').map(x=>x[0]).join('')}
        </div>
        <div>
          <div style="font-size:0.82rem;font-weight:500;">${s.name}</div>
          <div style="font-size:0.7rem;color:var(--text-muted);">${s.spec}</div>
        </div>
      </div>
      <span class="pill ${s.status==='Active'?'pill-green':s.status==='On Leave'?'pill-gold':'pill-gray'}">${s.status}</span>
    </div>`).join('');

  document.getElementById('dashApptTable').innerHTML=`
    <thead><tr><th>#</th><th>Customer</th><th>Service</th><th>Date</th><th>Status</th></tr></thead>
    <tbody>${appointments.slice(0,5).map(a=>`
      <tr>
        <td style="color:var(--text-muted)">#${a.id}</td>
        <td style="font-weight:500">${a.customer}</td>
        <td>${a.service}</td>
        <td style="color:var(--text-muted);font-size:0.8rem">${a.date} ${a.time}</td>
        <td><span class="pill ${statusPill(a.status)}">${a.status}</span></td>
      </tr>`).join('')}
    </tbody>`;

  document.getElementById('pendingBadge').textContent=appointments.filter(a=>a.status==='Pending').length;
}

/* â•â•â• USERS â•â•â• */
function addUser(e) {
  e.preventDefault();
  users.push({id:userIdCtr++,name:document.getElementById('uName').value,
    email:document.getElementById('uEmail').value,phone:document.getElementById('uPhone').value,
    status:document.getElementById('uStatus').value,joined:new Date().toISOString().split('T')[0]});
  e.target.reset(); renderUsers(); toast('âœ… User added successfully!');
}
function renderUsers() {
  const q=(document.getElementById('userSearch')?.value||'').toLowerCase();
  const f=document.getElementById('userFilter')?.value||'';
  const filtered=users.filter(u=>(u.name.toLowerCase().includes(q)||u.email.toLowerCase().includes(q))&&(!f||u.status===f));
  document.getElementById('userCount').textContent=filtered.length+' users';
  document.getElementById('userTable').innerHTML=filtered.map(u=>`
    <tr>
      <td data-label="#">#${u.id}</td>
      <td data-label="Name">
        <div style="display:flex;align-items:center;gap:0.6rem;">
          <div style="width:30px;height:30px;border-radius:9px;background:var(--rose-soft);display:flex;align-items:center;justify-content:center;font-size:0.68rem;font-weight:700;color:var(--rose);">${u.name.split(' ').map(x=>x[0]).join('')}</div>
          <span style="font-weight:500">${u.name}</span>
        </div>
      </td>
      <td data-label="Email" style="color:var(--text-muted)">${u.email}</td>
      <td data-label="Phone">${u.phone||'â€”'}</td>
      <td data-label="Status"><span class="pill ${u.status==='Active'?'pill-green':'pill-gray'}">${u.status}</span></td>
      <td data-label="Joined" style="color:var(--text-muted);font-size:0.8rem">${u.joined}</td>
      <td data-label="Actions"><div class="btn-group">
        <button class="btn btn-gold btn-sm" onclick="editUser(${u.id})"><i class="fas fa-edit"></i> Edit</button>
        <button class="btn btn-danger btn-sm" onclick="deleteUser(${u.id})"><i class="fas fa-trash"></i></button>
      </div></td>
    </tr>`).join('');
}
function editUser(id){
  const u=users.find(x=>x.id===id);
  showModal('Edit User',`<div class="form-grid">
    <div class="form-group"><label>Full Name</label><input class="form-control" id="euName" value="${u.name}"></div>
    <div class="form-group"><label>Email</label><input class="form-control" id="euEmail" value="${u.email}"></div>
    <div class="form-group"><label>Phone</label><input class="form-control" id="euPhone" value="${u.phone||''}"></div>
    <div class="form-group"><label>Status</label><select class="form-control" id="euStatus">
      <option ${u.status==='Active'?'selected':''}>Active</option>
      <option ${u.status==='Inactive'?'selected':''}>Inactive</option>
    </select></div></div>
    <button class="btn btn-rose" style="width:100%;justify-content:center;" onclick="saveUser(${id})"><i class="fas fa-save"></i> Save Changes</button>`);
}
function saveUser(id){
  const u=users.find(x=>x.id===id);
  u.name=document.getElementById('euName').value;
  u.email=document.getElementById('euEmail').value;
  u.phone=document.getElementById('euPhone').value;
  u.status=document.getElementById('euStatus').value;
  closeModal(); renderUsers(); toast('âœ… User updated!');
}
function deleteUser(id){
  if(!confirm('Delete this user?')) return;
  users=users.filter(u=>u.id!==id);
  renderUsers(); toast('ðŸ—‘ï¸ User deleted.','var(--red)');
}

/* â•â•â• APPOINTMENTS â•â•â• */
function filterAppt(f){apptFilter=f;renderAppts();}
function renderAppts(){
  const q=(document.getElementById('apptSearch')?.value||'').toLowerCase();
  const filtered=appointments.filter(a=>(apptFilter==='all'||a.status===apptFilter)&&(a.customer.toLowerCase().includes(q)||a.service.toLowerCase().includes(q)));
  document.getElementById('apptTable').innerHTML=filtered.map(a=>`
    <tr>
      <td style="color:var(--text-muted)">#${a.id}</td>
      <td style="font-weight:500">${a.customer}</td>
      <td>${a.service}</td>
      <td style="color:var(--text-muted)">${a.stylist}</td>
      <td style="font-size:0.8rem">${a.date}</td>
      <td style="font-size:0.8rem">${a.time}</td>
      <td><span class="pill ${statusPill(a.status)}">${a.status}</span></td>
      <td><div class="btn-group">
        <button class="btn btn-sm" style="background:var(--green-soft);color:var(--green)" onclick="setAppt(${a.id},'Confirmed')"><i class="fas fa-check"></i></button>
        <button class="btn btn-danger btn-sm" onclick="setAppt(${a.id},'Cancelled')"><i class="fas fa-times"></i></button>
        <button class="btn btn-gold btn-sm" onclick="editAppt(${a.id})"><i class="fas fa-edit"></i></button>
      </div></td>
    </tr>`).join('');
  document.getElementById('pendingBadge').textContent=appointments.filter(a=>a.status==='Pending').length;
}
function setAppt(id,status){
  appointments.find(a=>a.id===id).status=status;
  renderAppts();
  toast(status==='Confirmed'?'âœ… Appointment confirmed!':'âŒ Appointment cancelled.',status==='Confirmed'?'var(--green)':'var(--red)');
}
function editAppt(id){
  const a=appointments.find(x=>x.id===id);
  showModal('Edit Appointment',`<div class="form-grid">
    <div class="form-group"><label>Customer</label><input class="form-control" id="eaCustomer" value="${a.customer}"></div>
    <div class="form-group"><label>Service</label><input class="form-control" id="eaService" value="${a.service}"></div>
    <div class="form-group"><label>Stylist</label><select class="form-control" id="eaStylist">${staff.map(s=>`<option ${s.name===a.stylist?'selected':''}>${s.name}</option>`).join('')}</select></div>
    <div class="form-group"><label>Status</label><select class="form-control" id="eaStatus">${['Pending','Confirmed','Cancelled'].map(s=>`<option ${s===a.status?'selected':''}>${s}</option>`).join('')}</select></div>
    <div class="form-group"><label>Date</label><input type="date" class="form-control" id="eaDate" value="${a.date}"></div>
    <div class="form-group"><label>Time</label><input type="time" class="form-control" id="eaTime" value="${a.time}"></div></div>
    <button class="btn btn-rose" style="width:100%;justify-content:center;" onclick="saveAppt(${id})"><i class="fas fa-save"></i> Save Changes</button>`);
}
function saveAppt(id){
  const a=appointments.find(x=>x.id===id);
  a.customer=document.getElementById('eaCustomer').value;
  a.service=document.getElementById('eaService').value;
  a.stylist=document.getElementById('eaStylist').value;
  a.status=document.getElementById('eaStatus').value;
  a.date=document.getElementById('eaDate').value;
  a.time=document.getElementById('eaTime').value;
  closeModal(); renderAppts(); toast('âœ… Appointment updated!');
}

/* â•â•â• SERVICES â•â•â• */
function setSvcView(mode){
  svcViewMode=mode;
  document.getElementById('svcCardGrid').style.display=mode==='grid'?'grid':'none';
  document.getElementById('svcTableView').style.display=mode==='table'?'block':'none';
  document.getElementById('btnGrid').classList.toggle('active',mode==='grid');
  document.getElementById('btnTable').classList.toggle('active',mode==='table');
}

function previewImage(input){
  if(!input.files||!input.files[0]) return;
  const reader=new FileReader();
  reader.onload=e=>{
    selectedImageData=e.target.result;
    document.getElementById('imagePreview').src=e.target.result;
    document.getElementById('imagePreview').style.display='block';
    document.getElementById('dropzoneContent').style.display='none';
    // Update live preview
    document.getElementById('prevImg').src=e.target.result;
    document.getElementById('prevImg').style.display='block';
    document.getElementById('prevImgPlaceholder').style.display='none';
  };
  reader.readAsDataURL(input.files[0]);
}

function handleDrop(e){
  e.preventDefault();
  document.getElementById('imageDropzone').style.borderColor='var(--border2)';
  const file=e.dataTransfer.files[0];
  if(file&&file.type.startsWith('image/')){
    const dt=new DataTransfer(); dt.items.add(file);
    document.getElementById('svcImage').files=dt.files;
    previewImage(document.getElementById('svcImage'));
  }
}

function resetSvcForm(){
  document.getElementById('svcForm').reset();
  selectedImageData='';
  document.getElementById('imagePreview').style.display='none';
  document.getElementById('dropzoneContent').style.display='block';
  document.getElementById('prevImg').style.display='none';
  document.getElementById('prevImgPlaceholder').style.display='block';
  document.getElementById('prevName').textContent='Service Name';
  document.getElementById('prevPrice').textContent='LKR â€”';
  document.getElementById('prevDesc').textContent='Service description will appear here.';
}

// Live preview update on input
['svcName','svcPrice','svcDesc'].forEach(id=>{
  setTimeout(()=>{
    const el=document.getElementById(id);
    if(!el) return;
    el.addEventListener('input',()=>{
      if(id==='svcName') document.getElementById('prevName').textContent=el.value||'Service Name';
      if(id==='svcPrice') document.getElementById('prevPrice').textContent=el.value?'LKR '+parseFloat(el.value).toLocaleString():'LKR â€”';
      if(id==='svcDesc') document.getElementById('prevDesc').textContent=el.value||'Service description will appear here.';
    });
  },100);
});

function addService(e){
  e.preventDefault();
  const name=document.getElementById('svcName').value.trim();
  const price=parseFloat(document.getElementById('svcPrice').value);
  const desc=document.getElementById('svcDesc').value.trim();
  services.push({id:svcIdCtr++,name,price,desc,img:selectedImageData});
  resetSvcForm(); renderServices(); updateSvcStats();
  toast('âœ… Service added successfully!');
}

function renderServices(){
  const q=(document.getElementById('svcSearch')?.value||'').toLowerCase();
  const sort=document.getElementById('svcSort')?.value||'';
  let list=services.filter(s=>s.name.toLowerCase().includes(q)||s.desc.toLowerCase().includes(q));
  if(sort==='price-asc') list.sort((a,b)=>a.price-b.price);
  if(sort==='price-desc') list.sort((a,b)=>b.price-a.price);
  if(sort==='name') list.sort((a,b)=>a.name.localeCompare(b.name));

  document.getElementById('svcCount').textContent=list.length+' services';

  // Card grid
  document.getElementById('svcCardGrid').innerHTML=list.map(s=>`
    <div class="svc-thumb-card">
      <div class="svc-thumb-img">
        ${s.img?`<img src="${s.img}" alt="${s.name}">`:`<i class="fas fa-spa"></i>`}
      </div>
      <div class="svc-thumb-body">
        <div class="svc-thumb-name" title="${s.name}">${s.name}</div>
        <div class="svc-thumb-price">LKR ${s.price.toLocaleString()}</div>
        <div class="svc-thumb-desc">${s.desc}</div>
        <div class="svc-thumb-actions">
          <button class="btn btn-sm" style="background:var(--rose-soft);color:var(--rose);" onclick="openEditService(${s.id})"><i class="fas fa-edit"></i></button>
          <button class="btn btn-danger btn-sm" onclick="deleteService(${s.id})"><i class="fas fa-trash"></i></button>
        </div>
      </div>
    </div>`).join('');

  // Table view
  document.getElementById('svcTableBody').innerHTML=list.map(s=>`
    <tr>
      <td style="color:var(--text-muted);font-size:0.8rem">#${s.id}</td>
      <td>${s.img?`<img src="${s.img}" style="width:42px;height:42px;object-fit:cover;border-radius:8px;border:1px solid var(--border);">`
        :`<div style="width:42px;height:42px;border-radius:8px;background:var(--rose-soft);display:flex;align-items:center;justify-content:center;"><i class="fas fa-spa" style="color:var(--rose);"></i></div>`}</td>
      <td>${s.name}</td>
      <td style="color:var(--rose);font-weight:600;">LKR ${s.price.toLocaleString()}</td>
      <td style="color:var(--text-muted);font-size:0.82rem;max-width:200px;">${s.desc}</td>
      <td><div class="btn-group">
        <button class="btn btn-gold btn-sm" onclick="openEditService(${s.id})"><i class="fas fa-edit"></i> Edit</button>
        <button class="btn btn-danger btn-sm" onclick="deleteService(${s.id})"><i class="fas fa-trash"></i></button>
      </div></td>
    </tr>`).join('');

  updateSvcStats();
}

function updateSvcStats(){
  document.getElementById('svcStatTotal').textContent=services.length;
  const avg=services.length?Math.round(services.reduce((a,s)=>a+s.price,0)/services.length):0;
  const high=services.length?Math.max(...services.map(s=>s.price)):0;
  document.getElementById('svcStatAvgPrice').textContent='LKR '+avg.toLocaleString();
  document.getElementById('svcStatHighest').textContent='LKR '+high.toLocaleString();
}

function openEditService(id){
  const s=services.find(x=>x.id===id);
  showModal('Edit Service',`<div class="form-grid">
    <div class="form-group"><label>Service Name</label><input class="form-control" id="esName" value="${s.name}" required></div>
    <div class="form-group"><label>Price (LKR)</label><input type="number" class="form-control" id="esPrice" value="${s.price}" step="0.01" min="0" required></div>
    <div class="form-group form-full"><label>Description</label><input class="form-control" id="esDesc" value="${s.desc}"></div>
    <div class="form-group form-full"><label>Change Image</label><input type="file" id="esImage" accept="image/*" class="form-control"></div>
    ${s.img?`<div class="form-full" style="margin-top:-0.5rem"><img src="${s.img}" style="width:80px;height:60px;object-fit:cover;border-radius:8px;border:1px solid var(--border);"></div>`:''}
    </div>
    <button class="btn btn-rose" style="width:100%;justify-content:center;margin-top:0.5rem;" onclick="saveService(${id})"><i class="fas fa-save"></i> Save Changes</button>`);
}

function saveService(id){
  const s=services.find(x=>x.id===id);
  s.name=document.getElementById('esName').value.trim();
  s.price=parseFloat(document.getElementById('esPrice').value);
  s.desc=document.getElementById('esDesc').value.trim();
  const file=document.getElementById('esImage').files[0];
  if(file){
    const reader=new FileReader();
    reader.onload=e=>{s.img=e.target.result;closeModal();renderServices();toast('âœ… Service updated!');};
    reader.readAsDataURL(file);
  } else { closeModal(); renderServices(); toast('âœ… Service updated!'); }
}

function deleteService(id){
  if(!confirm('Delete this service?')) return;
  services=services.filter(s=>s.id!==id);
  renderServices(); toast('ðŸ—‘ï¸ Service deleted.','var(--red)');
}

/* â•â•â• STAFF â•â•â• */
function addStaff(e){
  e.preventDefault();
  staff.push({id:staffIdCtr++,name:document.getElementById('stName').value,
    spec:document.getElementById('stSpec').value,phone:document.getElementById('stPhone').value,
    email:document.getElementById('stEmail').value,exp:document.getElementById('stExp').value||0,
    status:document.getElementById('stStatus').value});
  e.target.reset(); renderStaff(); toast('âœ… Staff member added!');
}
function renderStaff(){
  const q=(document.getElementById('staffSearch')?.value||'').toLowerCase();
  const filtered=staff.filter(s=>s.name.toLowerCase().includes(q)||s.spec.toLowerCase().includes(q));
  document.getElementById('staffTable').innerHTML=filtered.map(s=>`
    <tr>
      <td style="color:var(--text-muted)">#${s.id}</td>
      <td><div style="display:flex;align-items:center;gap:0.6rem;">
        <div style="width:30px;height:30px;border-radius:9px;background:var(--rose-soft);display:flex;align-items:center;justify-content:center;font-size:0.68rem;font-weight:700;color:var(--rose);">${s.name.split(' ').map(x=>x[0]).join('')}</div>
        <span style="font-weight:500">${s.name}</span>
      </div></td>
      <td style="color:var(--text-muted)">${s.spec}</td>
      <td>${s.phone||'â€”'}</td>
      <td style="color:var(--text-muted)">${s.email||'â€”'}</td>
      <td style="text-align:center">${s.exp} yrs</td>
      <td><span class="pill ${s.status==='Active'?'pill-green':s.status==='On Leave'?'pill-gold':'pill-gray'}">${s.status}</span></td>
      <td><div class="btn-group">
        <button class="btn btn-gold btn-sm" onclick="editStaff(${s.id})"><i class="fas fa-edit"></i> Edit</button>
        <button class="btn btn-danger btn-sm" onclick="deleteStaff(${s.id})"><i class="fas fa-trash"></i></button>
      </div></td>
    </tr>`).join('');

  const active=staff.filter(s=>s.status==='Active').length;
  const onLeave=staff.filter(s=>s.status==='On Leave').length;
  document.getElementById('staffStats').innerHTML=`
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:0.75rem;">
      ${[['Total Staff',staff.length,'var(--rose)'],['Active',active,'var(--green)'],['On Leave',onLeave,'var(--gold)'],['Avg. Exp',Math.round(staff.reduce((a,s)=>a+ +s.exp,0)/staff.length)+' yrs','var(--rose)']].map(([l,v,c])=>`
      <div style="background:var(--cream);border-radius:10px;padding:1rem;text-align:center;">
        <div style="font-size:1.5rem;font-weight:700;color:${c};font-family:'Cormorant Garamond',serif">${v}</div>
        <div style="font-size:0.72rem;color:var(--text-muted)">${l}</div>
      </div>`).join('')}
    </div>`;
}
function editStaff(id){
  const s=staff.find(x=>x.id===id);
  showModal('Edit Staff',`<div class="form-grid">
    <div class="form-group"><label>Full Name</label><input class="form-control" id="esName" value="${s.name}"></div>
    <div class="form-group"><label>Specialization</label><input class="form-control" id="esSpec" value="${s.spec}"></div>
    <div class="form-group"><label>Phone</label><input class="form-control" id="esPhone" value="${s.phone||''}"></div>
    <div class="form-group"><label>Experience (yrs)</label><input type="number" class="form-control" id="esExp" value="${s.exp}"></div>
    <div class="form-group"><label>Status</label><select class="form-control" id="esStatus">${['Active','On Leave','Inactive'].map(x=>`<option ${x===s.status?'selected':''}>${x}</option>`).join('')}</select></div>
    </div>
    <button class="btn btn-rose" style="width:100%;justify-content:center;" onclick="saveStaff(${id})"><i class="fas fa-save"></i> Save Changes</button>`);
}
function saveStaff(id){
  const s=staff.find(x=>x.id===id);
  s.name=document.getElementById('esName').value;
  s.spec=document.getElementById('esSpec').value;
  s.phone=document.getElementById('esPhone').value;
  s.exp=document.getElementById('esExp').value;
  s.status=document.getElementById('esStatus').value;
  closeModal(); renderStaff(); toast('âœ… Staff updated!');
}
function deleteStaff(id){
  if(!confirm('Remove this staff member?')) return;
  staff=staff.filter(s=>s.id!==id);
  renderStaff(); toast('ðŸ—‘ï¸ Staff removed.','var(--red)');
}

/* â•â•â• ADMINS â•â•â• */
function addAdmin(e){
  e.preventDefault();
  const p1=document.getElementById('adPass').value;
  const p2=document.getElementById('adPass2').value;
  if(p1!==p2){toast('âš ï¸ Passwords do not match!','var(--red)');return;}
  if(p1.length<8){toast('âš ï¸ Password must be at least 8 characters!','var(--red)');return;}
  admins.push({id:adminIdCtr++,name:document.getElementById('adName').value,
    email:document.getElementById('adEmail').value,role:document.getElementById('adRole').value,
    status:document.getElementById('adStatus').value,lastLogin:'â€”'});
  e.target.reset(); renderAdmins(); toast('âœ… Admin account created!');
}
function renderAdmins(){
  document.getElementById('adminTable').innerHTML=admins.map(a=>`
    <tr>
      <td style="color:var(--text-muted)">#${a.id}</td>
      <td style="font-weight:500">${a.name}</td>
      <td style="color:var(--text-muted)">${a.email}</td>
      <td><span class="pill ${a.role==='Super Admin'?'pill-rose':a.role==='Manager'?'pill-gold':'pill-blue'}">${a.role}</span></td>
      <td><span class="pill ${a.status==='Active'?'pill-green':'pill-gray'}">${a.status}</span></td>
      <td style="color:var(--text-muted);font-size:0.8rem">${a.lastLogin}</td>
      <td><div class="btn-group">
        <button class="btn btn-gold btn-sm" onclick="editAdmin(${a.id})"><i class="fas fa-edit"></i> Edit</button>
        ${a.id!==1?`<button class="btn btn-danger btn-sm" onclick="deleteAdmin(${a.id})"><i class="fas fa-trash"></i></button>`:''}
      </div></td>
    </tr>`).join('');

  document.getElementById('rolePerms').innerHTML=[
    {role:'Super Admin',cls:'pill-rose',perms:['All access','Admin management','System settings','All reports']},
    {role:'Manager',cls:'pill-gold',perms:['User management','Appointments','Staff management','Reviews']},
    {role:'Staff Admin',cls:'pill-blue',perms:['View appointments','View users','Basic reports']},
  ].map(r=>`
    <div style="margin-bottom:0.9rem;padding:0.9rem;background:var(--cream);border-radius:10px;">
      <div style="margin-bottom:0.6rem;"><span class="pill ${r.cls}">${r.role}</span></div>
      ${r.perms.map(p=>`<div style="font-size:0.78rem;color:var(--text-muted);padding:0.12rem 0;"><i class="fas fa-check" style="color:var(--rose);margin-right:0.4rem;font-size:0.65rem;"></i>${p}</div>`).join('')}
    </div>`).join('');
}
function editAdmin(id){
  const a=admins.find(x=>x.id===id);
  showModal('Edit Admin',`<div class="form-grid">
    <div class="form-group"><label>Full Name</label><input class="form-control" id="eadName" value="${a.name}"></div>
    <div class="form-group"><label>Email</label><input class="form-control" id="eadEmail" value="${a.email}"></div>
    <div class="form-group"><label>Role</label><select class="form-control" id="eadRole">${['Super Admin','Manager','Staff Admin'].map(r=>`<option ${r===a.role?'selected':''}>${r}</option>`).join('')}</select></div>
    <div class="form-group"><label>Status</label><select class="form-control" id="eadStatus">${['Active','Inactive'].map(s=>`<option ${s===a.status?'selected':''}>${s}</option>`).join('')}</select></div>
    </div>
    <button class="btn btn-rose" style="width:100%;justify-content:center;" onclick="saveAdmin(${id})"><i class="fas fa-save"></i> Save Changes</button>`);
}
function saveAdmin(id){
  const a=admins.find(x=>x.id===id);
  a.name=document.getElementById('eadName').value;
  a.email=document.getElementById('eadEmail').value;
  a.role=document.getElementById('eadRole').value;
  a.status=document.getElementById('eadStatus').value;
  closeModal(); renderAdmins(); toast('âœ… Admin updated!');
}
function deleteAdmin(id){
  if(!confirm('Delete this admin account?')) return;
  admins=admins.filter(a=>a.id!==id);
  renderAdmins(); toast('ðŸ—‘ï¸ Admin deleted.','var(--red)');
}

/* â•â•â• FEEDBACK â•â•â• */
function filterReviews(f){reviewFilter=f;renderFeedback();}
function renderFeedback(){
  const q=(document.getElementById('reviewSearch')?.value||'').toLowerCase();
  const filtered=reviews.filter(r=>(!reviewFilter||(reviewFilter===3?r.stars<=3:r.stars===reviewFilter))&&(r.name.toLowerCase().includes(q)||r.text.toLowerCase().includes(q)));
  document.getElementById('totalReviews').textContent=reviews.length;
  document.getElementById('feedbackTable').innerHTML=filtered.map((r,i)=>`
    <tr>
      <td style="font-weight:500">${r.name}</td>
      <td><span class="stars">${'â˜…'.repeat(r.stars)}${'â˜†'.repeat(5-r.stars)}</span></td>
      <td style="color:var(--text-muted);font-size:0.82rem;max-width:280px;">${r.text}</td>
      <td style="color:var(--text-muted);font-size:0.78rem;white-space:nowrap">${r.date}</td>
      <td><button class="btn btn-danger btn-sm" onclick="deleteReview(${i})"><i class="fas fa-trash"></i></button></td>
    </tr>`).join('');
}
function deleteReview(i){
  if(!confirm('Delete this review?')) return;
  reviews.splice(i,1); renderFeedback(); toast('ðŸ—‘ï¸ Review deleted.','var(--red)');
}

/* â•â•â• HELPERS â•â•â• */
function statusPill(s){return s==='Confirmed'?'pill-green':s==='Pending'?'pill-gold':s==='Cancelled'?'pill-red':'pill-gray';}
function showModal(title,body){
  document.getElementById('modalTitle').textContent=title;
  document.getElementById('modalBody').innerHTML=body;
  document.getElementById('modalBg').classList.add('open');
}
function closeModal(){document.getElementById('modalBg').classList.remove('open');}
document.getElementById('modalBg').addEventListener('click',e=>{if(e.target.id==='modalBg')closeModal();});
function toast(msg,accent='var(--rose)'){
  const t=document.getElementById('toast');
  t.textContent=msg; t.style.borderLeftColor=accent;
  t.classList.add('show');
  setTimeout(()=>t.classList.remove('show'),3000);
}

/* â•â•â• INIT â•â•â• */
renderDashboard();