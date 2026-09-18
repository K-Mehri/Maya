import { createFileRoute } from "@tanstack/react-router";

export const Route = createFileRoute("/users/")({
  component: RouteComponent,
});

function RouteComponent() {
  return (
    <>
      <div>users main page</div>
      <div className="text-orange-600">Hi I'm Maya :)</div>
      <div className="text-orange-600">
        Your workflow, your rules, automated with Maya...
      </div>
    </>
  );
}
