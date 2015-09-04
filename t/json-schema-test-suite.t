=head1 PURPOSE

Testing all the tests found in the json-schema-test-suite.

=cut
## skip Test::Tabs

use strict;
use warnings;
use Test::More;
use JSON;

use JSON::Validator;
use Test::JSON::Schema::Acceptance;


my $accepter = Test::JSON::Schema::Acceptance->new();

#Skip tests which are known not to be supported and cause problems.
# my $skip_tests = ['multiple extends', 'dependencies', 'ref', 10, 17, 58, 81, 115, 134, 'null is'];
my $skip_tests = [];

$accepter->acceptance(sub{
  my $schema = shift;
  my $input = JSON->new->allow_nonref->decode(shift);
  my $return;

  my $validator = JSON::Validator->new;

  # $return = JSON::Schema->new($schema)->validate($input);
  $validator->schema($schema);
  $return = $validator->validate($input);

  return $return;

}, { skip_tests => $skip_tests });

done_testing;
