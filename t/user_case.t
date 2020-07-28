use Mojo::Base -async_await;
use Syntax::Keyword::Try;
use User;
use Test::More;

async sub get_profile {
    my $user = shift;

    try {
        my $p = await $user->get_profile_p;
        isa_ok( $p, 'HASH');
        for (qw/name gender birthday/) {
            ok defined $p->{$_}, "ok user has $_ ($p->{$_})";
        }
    } catch {
        like $@, qr/Fake error/, "Expected error ($@)"
    }

}

# a bunch of users profile
foreach my $user ( map { User->new } 1..5 ) {
    get_profile($user)->wait;
}

done_testing;
