# Phoenix LiveView WYSIWYG CMS

The simplest CMS for Phoenix LiveView that transforms any webpage into an editable interface using the native `contenteditable` attribute.

## 🌟 Features

- **Inline Editing**: Click on any content area to edit it directly on the page
- **Real-time Updates**: Automatically saves changes to the database via Phoenix LiveView
- **WYSIWYG Interface**: What You See Is What You Get - edit content exactly as it appears
- **No Admin Panel Required**: The website itself becomes the admin interface

## 🚀 Quick Start

### Prerequisites

- Elixir 1.15+
- Phoenix 1.8+
- SQLite (or your preferred database)

### Installation

1. **Clone and setup**:
```bash
git clone <repository-url>
cd content
mix setup
```

2. **Start the server**:
```bash
mix phx.server
```

3. **Visit the demo**: Open [http://localhost:4000](http://localhost:4000)

4. **Start editing**: Click on any text content to edit it inline!

## 🎯 How It Works

The magic happens through the `ContentEditable` JavaScript hook that:

1. Makes any element with `phx-hook="ContentEditable"` editable
2. Listens for blur events when editing is complete
3. Automatically saves changes to the database via Phoenix LiveView
4. Updates the content in real-time across all connected clients

### Key Components

#### 1. HTML Template Usage

```heex
<h1
  id="heading-content"
  phx-hook="ContentEditable"
  data-slug="heading"
  class="text-4xl font-bold"
>
  {Map.get(@entries_by_slug, "heading", "Default Heading")}
</h1>
```

#### 2. ContentEditable Hook (`assets/js/app.js`)

```javascript
const ContentEditable = {
  mounted() {
    this.el.contentEditable = "true";

    this.el.addEventListener("blur", () => {
      const slug = this.el.dataset.slug;
      const text = this.el.innerHTML;

      if (slug && text) {
        this.pushEvent("set_content", { slug: slug, text: text });
      }
    });
  },
};
```







## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐
│   Browser       │    │   Phoenix        │    │   Database      │
│                 │    │   LiveView       │    │                 │
│ ContentEditable │◄──►│                  │◄──►│   entries
│ Hook            │    │ handle_event     │    │   - slug        │
│                 │    │ "set_content"    │    │   - text        │
└─────────────────┘    └──────────────────┘
```



### Extending the Hook

You can enhance the `ContentEditable` hook to add features like:

- **Rich text editing** (bold, italic, links)
- **Autosave** while typing
- **Validation** before saving
- **Loading states** during saves
- **Keyboard shortcuts** (Ctrl+S to save)



## 🔒 Security Considerations

For production use, consider:

1. **Content Sanitization**: Add HTML sanitization to prevent XSS attacks
2. **Authentication**: Restrict editing to authenticated users
3. **Validation**: Validate content before saving
4. **Rate Limiting**: Prevent abuse of the save endpoint


## 🙏 Acknowledgments

- Inspired by [hyperclay](https://hyperclay.com/)
