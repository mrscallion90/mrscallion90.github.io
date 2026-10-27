/* Duit Sense — two small enhancements.
   1. Mobile navigation toggle.
   2. Accordion: open one answer at a time.
   Everything else is HTML and CSS. */

/* Mobile navigation */
const navToggle = document.querySelector(".nav-toggle");
const siteNav = document.getElementById("site-nav");

if (navToggle && siteNav) {
  const setNav = (open) => {
    navToggle.setAttribute("aria-expanded", String(open));
    if (open) {
      siteNav.setAttribute("data-open", "true");
    } else {
      siteNav.removeAttribute("data-open");
    }
  };

  navToggle.addEventListener("click", () => {
    setNav(navToggle.getAttribute("aria-expanded") !== "true");
  });

  siteNav.addEventListener("click", (event) => {
    if (event.target.closest("a")) setNav(false);
  });

  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape" && siteNav.hasAttribute("data-open")) {
      setNav(false);
      navToggle.focus();
    }
  });

  window.matchMedia("(min-width: 768px)").addEventListener("change", (event) => {
    if (event.matches) setNav(false);
  });
}

/* Accordion: one open panel per group */
document.querySelectorAll(".accordion details").forEach((item) => {
  item.addEventListener("toggle", () => {
    if (!item.open) return;
    item
      .closest(".accordion")
      .querySelectorAll("details[open]")
      .forEach((other) => {
        if (other !== item) other.open = false;
      });
  });
});
