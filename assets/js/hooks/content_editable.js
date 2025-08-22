const ContentEditable = {
  mounted() {
    this.setupContentEditable();
  },

  updated() {
    this.setupContentEditable();
  },

  destroyed() {
    // Clean up event listener when the hook is destroyed
    if (this.blurHandler) {
      this.el.removeEventListener("blur", this.blurHandler);
    }
  },

  setupContentEditable() {
    this.el.contentEditable = "true";

    // Remove existing listener to avoid duplicates
    if (this.blurHandler) {
      this.el.removeEventListener("blur", this.blurHandler);
    }

    this.blurHandler = () => {
      const slug = this.el.dataset.slug;
      const text = this.el.innerHTML;
      if (slug && text) {
        this.pushEvent("set_content", { slug: slug, text: text });
      }
    };

    this.el.addEventListener("blur", this.blurHandler);
  },
};

export default ContentEditable;
