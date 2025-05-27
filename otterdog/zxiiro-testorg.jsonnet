local orgs = import 'vendor/.otterdog/otterdog-defaults/otterdog-defaults.libsonnet';

local customRuleset(name) =
  orgs.newRepoRuleset(name) {
    include_refs+: [
      std.format("refs/heads/%s", name),
    ],
    required_pull_request+: {
      required_approving_review_count: 1,
      requires_last_push_approval: true,
      requires_review_thread_resolution: true,
      dismisses_stale_reviews: true,
    },
    requires_linear_history: true,
  };

local protectTags() = orgs.newRepoRuleset('tags-protection') {
  target: "tag",
  include_refs: [
    '~ALL'
  ],
  allows_creations: true,
  allows_deletions: false,
  allows_updates: false,
  required_pull_request: null,
  required_status_checks: null,
};

orgs.newOrg('zxtest.atest', 'zxiiro-testorg') {
  settings+: {
    description: "A test org 2",
    has_discussions: false,
    name: "Just a test",
    web_commit_signoff_required: false,
  },
  _repositories+:: [
    orgs.newRepo('.otterdog') {
      has_discussions: true,
      private: true,
    },
    orgs.newRepo('.zxdog') {
      description: "Project Config",
      private: false,
    },
    orgs.newRepo('test-repo') {
      description: "Yeah",
      private: false,
      environments: [
        orgs.newEnvironment('linux') {
          deployment_branch_policy: "protected",
          reviewers+: [
            "@zxiiro",
          ],
          wait_timer: 30,
        },
      ]
    },
  ],
}
