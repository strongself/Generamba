# Vision

Generamba is a tool with one primary role:

> Routine tasks automation through code generation.

At first it was designed to work only with Xcode - IDE for iOS/macOS, but as time passed we saw a lot of opportunities to use it in other circumstances, e.g. in frontend, Android and backend development.

### What Is Generamba

The Generamba core is a simple generator that takes a [liquid](https://shopify.github.io/liquid/) template and a set of parameters as an input and produces a text snippet as an output. Everything else is built upon this simple concept.

There are a lot of IDE's, package managers and other stuff which is related to creating new code modules. We try to keep the core small but provide rich opportunities for integration with all these tools via plugins *(in development)* and templates *(ready to use)* systems.

### General Aim

Our general aim is to provide a simple yet extensible way to generate any piece of code. The beginner should be able to create new code modules without complex configuration process. Generamba capabilities should grow as fast as the user needs, providing ways to validate the environment status, integrations with different file systems and IDEs, complex statements inside templates and so on.

### Templates

Code templates are the fuel for Generamba. We use a [liquid](https://shopify.github.io/liquid/) markup, because of its beautiful syntax and the ability to implement really complex logic.

Templates may be private as well as adopted for public. We provide a number of ways to install them - using local paths, remote git repository, public or private catalogs.

We also maintain a [public catalog](https://github.com/rambler-digital-solutions/generamba-catalog) which has some popular templates for iOS/macOS projects.

### Communication

We try to keep all the discussion about Generamba within [GitHub issues](https://github.com/rambler-digital-solutions/Generamba/issues). This attitude allows us to keep our processes and intentions transparent.

Besides it there is a private Telegram channel where maintainers discuss work questions. We are considering moving to Slack or Gitter at some point in the future - but we haven't grown big enough yet.

### Contributions

Despite main maintainers are engineers from Rambler&Co team, we are glad to welcome external contributors. Generamba has evolved a lot since the first alpha release thanks to a lot of ideas from its users that came in the form of issues and pull requests.

The aim of our core team is to adopt Generamba possibilities to each user needs and provide him a way to extend its functionality himself.

### ...

The structure and idea of *VISION.md* file was taken from the [Danger](https://github.com/danger/danger) project and [@orta](https://github.com/orta).
