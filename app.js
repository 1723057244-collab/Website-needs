/**
 * app.js — Shared utilities for Aocheng Lighting website
 * Handles: navbar active state, mobile menu, language switching, toast, contact form
 */

// ===== STATE =====
// Detect browser language on first visit, then persist in localStorage
var savedLang = localStorage.getItem('aocLang');
if (!savedLang) {
  savedLang = (navigator.language || navigator.userLanguage || 'zh').startsWith('zh') ? 'zh' : 'en';
  localStorage.setItem('aocLang', savedLang);
}
let currentLang = savedLang;

// ===== MOBILE MENU =====
function toggleMenu() {
  document.getElementById('mainNav').classList.toggle('open');
}

// ===== LANGUAGE =====
function t(key) {
  return (I18N[currentLang] && I18N[currentLang][key]) ? I18N[currentLang][key] : key;
}

function toggleLang() {
  setLang(currentLang === 'zh' ? 'en' : 'zh');
}

function setLang(lang) {
  currentLang = lang;
  localStorage.setItem('aocLang', lang);
  document.documentElement.lang = lang === 'zh' ? 'zh-CN' : 'en';
  document.body.classList.toggle('lang-en', lang === 'en');
  var langLabel = document.getElementById('langLabel');
  if (langLabel) langLabel.textContent = lang === 'zh' ? 'EN' : '中文';

  // Update all data-i18n elements
  document.querySelectorAll('[data-i18n]').forEach(function(el) {
    var key = el.getAttribute('data-i18n');
    var val = t(key);
    if (val.indexOf('<strong>') !== -1 || val.indexOf('<br>') !== -1) {
      el.innerHTML = val;
    } else {
      el.textContent = val;
    }
  });

  // Update placeholder attributes
  document.querySelectorAll('[data-i18n-placeholder]').forEach(function(el) {
    el.placeholder = t(el.getAttribute('data-i18n-placeholder'));
  });

  // Update nav links
  var navKeys = ['nav.home','nav.products','nav.catalog','nav.about','nav.features','nav.careers','nav.contact'];
  document.querySelectorAll('header nav a').forEach(function(a, i) {
    if (navKeys[i]) a.textContent = t(navKeys[i]);
  });

  // Update page title
  document.title = lang === 'zh' ? '江门市澳成科技照明有限公司 - 专业办公照明解决方案提供商' : 'Jiangmen Aocen Technology Lighting Co., Ltd. - Professional Office Lighting Solutions';
}

// ===== TOAST =====
var toastTimer;
function showToast(msg, type) {
  var toast = document.getElementById('toast');
  if (!toast) return;
  toast.textContent = msg;
  toast.className = 'toast ' + (type || '');
  setTimeout(function() { toast.classList.add('show'); }, 10);
  clearTimeout(toastTimer);
  toastTimer = setTimeout(function() { toast.classList.remove('show'); }, 3000);
}

// ===== CONTACT FORM =====
function submitMessage() {
  var fields = {
    company: document.getElementById('msg_company'),
    name: document.getElementById('msg_name'),
    position: document.getElementById('msg_position'),
    contact: document.getElementById('msg_contact'),
    message: document.getElementById('msg_message')
  };

  // Validate
  var hasError = false;
  var errEl = document.getElementById('formError');
  if (errEl) { errEl.classList.remove('show'); errEl.textContent = ''; }

  // Reset borders
  Object.values(fields).forEach(function(f) { if (f) f.style.borderColor = ''; });

  for (var key in fields) {
    var el = fields[key];
    if (!el) continue;
    if (!el.value.trim()) {
      hasError = true;
      el.style.borderColor = '#e44';
    }
  }

  if (hasError) {
    if (errEl) {
      errEl.textContent = (currentLang === 'zh'
        ? '请填写所有必填字段（标有 * 的字段）'
        : 'Please fill in all required fields (marked with *)');
      errEl.classList.add('show');
    }
    return;
  }

  // Build email
  var subject = currentLang === 'zh'
    ? '【澳成照明官网留言】' + fields.name.value + ' - ' + fields.company.value
    : '[Aocen Lighting Website Message] ' + fields.name.value + ' - ' + fields.company.value;

  var body = [
    '═══════════════════════════════',
    currentLang === 'zh' ? '  澳成照明官网 - 在线留言' : '  Aocen Lighting - Website Message',
    '═══════════════════════════════',
    '',
    (currentLang === 'zh' ? '单位名称' : 'Company') + ': ' + fields.company.value,
    (currentLang === 'zh' ? '姓名' : 'Name') + ': ' + fields.name.value,
    (currentLang === 'zh' ? '职位' : 'Position') + ': ' + fields.position.value,
    (currentLang === 'zh' ? '联系方式' : 'Contact') + ': ' + fields.contact.value,
    '',
    (currentLang === 'zh' ? '留言内容' : 'Message') + ':',
    fields.message.value,
    '',
    '───────────────────────────────',
    currentLang === 'zh' ? '发送自澳成照明官网留言系统' : 'Sent from Aocen Lighting Website Message System',
    new Date().toLocaleString(),
  ].join('\n');

  // Open mail client
  var mailto = 'mailto:lin@aoc2005.com?subject=' + encodeURIComponent(subject) + '&body=' + encodeURIComponent(body);
  window.location.href = mailto;

  // Show success
  var formFields = document.getElementById('formFields');
  var formSuccess = document.getElementById('formSuccess');
  if (formFields) formFields.style.display = 'none';
  if (formSuccess) formSuccess.classList.add('show');

  showToast(t('contact.successTitle'), 'success');
}

function resetForm() {
  ['msg_company','msg_name','msg_position','msg_contact','msg_message'].forEach(function(id) {
    var el = document.getElementById(id);
    if (el) { el.value = ''; el.style.borderColor = ''; }
  });
  var formError = document.getElementById('formError');
  var formFields = document.getElementById('formFields');
  var formSuccess = document.getElementById('formSuccess');
  if (formError) formError.classList.remove('show');
  if (formFields) formFields.style.display = '';
  if (formSuccess) formSuccess.classList.remove('show');
}

// ===== INIT =====
function initCommon() {
  // Header scroll effect
  window.addEventListener('scroll', function() {
    var header = document.getElementById('header');
    if (header) header.classList.toggle('scrolled', window.scrollY > 50);
  });

  // Close mobile menu on outside click
  document.addEventListener('click', function(e) {
    var nav = document.getElementById('mainNav');
    var toggle = document.querySelector('.menu-toggle');
    if (nav && toggle && !nav.contains(e.target) && !toggle.contains(e.target)) {
      nav.classList.remove('open');
    }
  });
}

document.addEventListener('DOMContentLoaded', initCommon);
