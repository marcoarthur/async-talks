use Mojolicious::Lite -async_await, -signatures;
use Syntax::Keyword::Try;
use User;

get '/user' => async sub ($c) {
    $c->render_later;
    try {
        my $user = await User->new->get_profile_p;
        $c->render( json => $user );
    } catch {
        $c->reply->exception("Oh no: $@");
    }
};

app->start;
