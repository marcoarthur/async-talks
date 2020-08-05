use Mojo::Base -async_await, -signatures;
use Test::More;
use Test::Mojo;
use Mojo::File 'path';

my $script = path('.', 'lib', 'Web', 'user.pl');
my $t = Test::Mojo->new($script);

async sub test_user {
    $t->get_ok('/user')->status_is(200)
    ->json_like('/birthday' => qr/\d{4}-\d{2}-\d{2}/)
    ->json_like('/gender' => qr/Female|Male|Other/);

}

test_user->wait();
done_testing;
